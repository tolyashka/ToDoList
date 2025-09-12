//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import Foundation

final class CoreDataManager {
    typealias CoreDataResult = Result<[ToDo], CoreDataError>
    private let coreDataClient: ICoreDataClient
    
    init(coreDataClient: ICoreDataClient) {
        self.coreDataClient = coreDataClient
    }
}

extension CoreDataManager: ICoreDataManager {
    func save(tasks: [ToDo]) {
        coreDataClient.save(tasks: tasks)
    }
    
    func delete(with id: Int, completionHandler: @escaping (Result<ToDo, CoreDataError>) -> Void) {
        coreDataClient.deleteTask(withId: id) { (result: Result<ToDo, CoreDataError>) in
                switch result {
                case .success(let model):
                    completionHandler(.success(model))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void
    ) {
        dataUploadingHandler(.beingUploaded)
        coreDataClient.fetchTasks { (result: CoreDataResult) in
            dataUploadingHandler(.uploaded)
            switch result {
            case .success(let tasks):
                completionHandler(.success(tasks))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func sortWithTitle(
        matching query: String?,
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void
    ) {
        dataUploadingHandler(.beingUploaded)
        coreDataClient.sortWithTitle(
            matching: query) { (result: CoreDataResult) in
                dataUploadingHandler(.uploaded)
                switch result {
                case .success(let model):
                    completionHandler(.success(model))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func updateState(
        for id: Int,
        newState: Bool,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void
    ) {
            coreDataClient.updateCompletedState(
                for: id,
                isCompleted: newState) { (result: CoreDataResult) in
                    switch result {
                    case .success(let model):
                        completionHandler(.success(model))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
        }
}
