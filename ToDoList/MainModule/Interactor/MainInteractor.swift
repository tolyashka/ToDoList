//
//  Interactor.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

final class MainModuleInteractor: InteractorInput {
    weak var output: InteractorOutput?
    
    private let taskRepository: ITaskRepository
    private var currentState: TaskLoadingState?
    
    init(taskRepository: ITaskRepository) {
        self.taskRepository = taskRepository
    }
}

extension MainModuleInteractor {
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
                DispatchQueue.main.async {
                    self.output?.didLoadTasks(taskModel)
                }
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
                DispatchQueue.main.async {
                    self.output?.didLoadTasks(taskModel)
                }
            case .failure(let error):
                output?.didFailLoading(error: error)
            }
        }
    }
    
    func filterTasks(with query: String) {
        taskRepository.sortWithTitle(
            matching: query) { [weak self] loadState in
                guard let self else { return }
                switch loadState {
                case .beingUploaded:
                    output?.didStartLoading()
                case .uploaded:
                    output?.didFinishLoading()
                case .uploadWithError(let error):
                    output?.didFailLoading(error: error)
                }
            } completionHandler: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.output?.didLoadTasks(model)
                    }
                case .failure(let error):
                    output?.didFailLoading(error: error)
                }
            }
    }
    
    func deleteTask(with id: Int) {
        taskRepository.delete(
            with: id) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let task):
                    DispatchQueue.main.async {
                        self.output?.didDelete(task: task)
                    }
                case .failure(let error):
                    output?.didFailLoading(error: error)
                }
            }
    }
}

private extension MainModuleInteractor {
    func transition(to newState: TaskLoadingState) {
        currentState = newState
        if let output {
            currentState?.execute(on: output)
        }
    }
}
