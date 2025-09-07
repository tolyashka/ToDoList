//
//  CoreDataClientProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

protocol ICoreDataClient: AnyObject {
    func fetchTasks<Model: CoreDataMappable>(
        with completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    )
    
    func updateCompletedState<Model: CoreDataMappable>(
            for id: Int,
            isCompleted: Bool,
            completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    )
    
    func save<Model: CoreDataMappable>(tasks: [Model])
}
