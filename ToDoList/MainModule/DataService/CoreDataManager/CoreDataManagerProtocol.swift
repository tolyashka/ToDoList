//
//  ManagerProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

protocol ICoreDataManager: AnyObject {
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], Error>) -> Void
    )
    
    func updateState(
        for id: Int,
        newState: Bool,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void)
    
    func save(tasks: [ToDo])
}
