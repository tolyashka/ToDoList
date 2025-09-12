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
    
    func sortWithTitle(
        matching query: String?,
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void
    )
    
    func delete(
        with id: Int,
        completionHandler: @escaping (Result<ToDo, CoreDataError>) -> Void)
}

final class TaskRepository {
    private let networkManager: INetworkManager
    private let localManager: ICoreDataManager
    
    init(networkManager: INetworkManager, localManager: ICoreDataManager) {
        self.networkManager = networkManager
        self.localManager = localManager
    }
}

extension TaskRepository: ITaskRepository {
    func delete(with id: Int, completionHandler: @escaping (Result<ToDo, CoreDataError>) -> Void) {
        localManager.delete(with: id, completionHandler: completionHandler)
    }
    
    func sortWithTitle(matching query: String?, dataUploadingHandler: @escaping (LoadState) -> Void, completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void) {
        localManager.sortWithTitle(
            matching: query,
            dataUploadingHandler: dataUploadingHandler, completionHandler: completionHandler
        )
    }
    
    
    
    func updateState(
        for id: Int,
        newState: Bool,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void) {
            localManager.updateState(for: id, newState: newState, completionHandler: completionHandler)
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
