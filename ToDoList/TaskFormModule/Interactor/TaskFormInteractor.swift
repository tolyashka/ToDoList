//
//  NewTaskInteractor.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

final class TaskFormInteractor: TaskFormInteractorInput {
    weak var output: TaskFormInteractorOutput?
    private let taskRepository: ITaskFormRepository
    
    init(taskRepository: ITaskFormRepository) {
        self.taskRepository = taskRepository
    }
    
    func save(task: TaskDraft) {
        taskRepository.saveNewTask(from: task) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self?.output?.didFailSavingTask(error: error)
            }
        }
    }
    
    func update(for id: Int, with draft: TaskDraft) {
        taskRepository.update(for: id, with: draft)
    }
}
