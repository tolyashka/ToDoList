//
//  DataManager.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 08.09.2025.
//

import Foundation

final class TaskFormDataManager: ITaskFormDataManager {
    typealias TaskResult = (Result<ToDo, CoreDataError>) -> Void
    
    private let dataClient: ICoreDataClient
    private let idGenerator: ITaskIdGeneratorService
    
    init(
        dataClient: ICoreDataClient,
        idGenerator: ITaskIdGeneratorService
    ) {
        self.dataClient = dataClient
        self.idGenerator = idGenerator
    }
    
    func update(for id: Int, with draft: TaskDraft) {
        dataClient.update(for: id, with: draft)
    }
    
    func saveNewTask(
        from draft: TaskDraft,
        completion: @escaping TaskResult
    ) {
        dataClient.fetchLastTask { [weak self] (result: Result<ToDo, CoreDataError>) in
            switch result {
            case .success(let lastTask):
                guard let self else { return }
                let newId = idGenerator.nextId(from: lastTask.id)
                let newTask = createTask(with: newId, draft: draft)
                dataClient.save(task: newTask, completionHandler: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createTask(with id: Int, draft: TaskDraft) -> ToDo {
        let newTask = ToDo(
            id: id,
            todo: draft.todo,
            completed: false,
            userId: 0
        )
        
        return newTask
    }
}
