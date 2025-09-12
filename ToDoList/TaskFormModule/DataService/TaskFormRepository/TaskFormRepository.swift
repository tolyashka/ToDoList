//
//  NewTaskRepository.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 10.09.2025.
//

import Foundation

final class TaskFormRepository: ITaskFormRepository {
    private let dataManager: ITaskFormDataManager
    
    init(dataManager: ITaskFormDataManager) {
        self.dataManager = dataManager
    }
    
    func update(for id: Int, with draft: TaskDraft) {
        dataManager.update(for: id, with: draft)
    }
    
    func saveNewTask(
        from draft: TaskDraft,
        completion: @escaping (Result<ToDo, CoreDataError>) -> Void
    ) {
        dataManager.saveNewTask(from: draft, completion: completion)
    }
}
