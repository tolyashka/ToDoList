//
//  Repository.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 04.09.2025.
//

import Foundation

protocol ITaskRepository: AnyObject {
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], Error>) -> Void
    )
    
    func updateState(
        for id: Int,
        newState: Bool,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void)
    
}

final class TaskRepository {
    private let networkManager: INetworkManager
    private let localManager: any ICoreDataManager
    
    init(networkManager: INetworkManager, localManager: any ICoreDataManager) {
        self.networkManager = networkManager
        self.localManager = localManager
    }
}

extension TaskRepository: ITaskRepository {
    func updateState(
        for id: Int,
        newState: Bool,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void) {
            localManager.updateState(for: id, newState: newState) { result in
                switch result {
                case .success(let resultModel):
                    completionHandler(.success(resultModel))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], Error>) -> Void
    ) {
        localManager.fetchTasks(dataUploadingHandler: dataUploadingHandler) { [weak self] result in
            switch result {
            case .success(let cachedTasks):
                completionHandler(.success(cachedTasks))
                
            case .failure:
                self?.networkManager.fetchTasks(dataUploadingHandler: dataUploadingHandler) { result in
                    switch result {
                    case .success(let tasks):
                        self?.localManager.save(tasks: tasks.todos)
                        completionHandler(.success(tasks.todos))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            }
        }
    }
}
