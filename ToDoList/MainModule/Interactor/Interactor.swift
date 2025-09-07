//
//  Interactor.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

protocol InteractorInput: AnyObject {
    var output: InteractorOutput? { get set }
    
    func changeState(with id: Int, newState: Bool)
    func fetchData()
}

protocol InteractorOutput: AnyObject {
    func didStartLoading()
    func didFinishLoading()
    func didFailLoading(error: Error)
    func didLoadTasks(_ model: [ToDo])
}

final class Interactor: InteractorInput {
    weak var output: InteractorOutput?
    
    private let taskRepository: ITaskRepository
    private var currentState: TaskLoadingState?
    
    init(taskRepository: ITaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func fetchData() {
        taskRepository.fetchTasks { [weak self] loadState in
            guard let self else { return }
            switch loadState {
            case .beingUploaded:
                transition(to: LoadingState())
            case .uploaded:
                transition(to: UploadedState())
            case .uploadWithError(let error):
                transition(to: FailureUploadState(error: error))
            }
        } completionHandler: { [weak self] resultModel in
            guard let self else { return }
            switch resultModel {
            case .success(let taskModel):
                output?.didLoadTasks(taskModel)
            case .failure(let error):
                output?.didFailLoading(error: error)
            }
        }
    }
    
    func changeState(
        with id: Int,
        newState: Bool) {
        taskRepository.updateState(for: id, newState: newState) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let taskModel):
                output?.didLoadTasks(taskModel)
            case .failure(let error):
                output?.didFailLoading(error: error)
            }
        }
    }
            
    private func transition(to newState: TaskLoadingState) {
        currentState = newState
        if let output {
            currentState?.execute(on: output)
        }
    }
}
