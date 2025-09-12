//
//  CoreDataClientProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

protocol ICoreDataClient: AnyObject {
    func save<Model: CoreDataMappable>(tasks: [Model])
    func update<Draft: CoreDataDraft>(for id: Int, with draft: Draft)
    
    func fetchTasks<Model: CoreDataMappable>(
        with completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    )
    
    func updateCompletedState<Model: CoreDataMappable>(
        for id: Int,
        isCompleted: Bool,
        completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    )
    
    func fetchLastTask<Model: CoreDataMappable>(
        completionHandler: @escaping (Result<Model, CoreDataError>) -> Void
    )
    
    func save<Model: CoreDataMappable>(
        task: Model,
        completionHandler: @escaping (Result<Model, CoreDataError>) -> Void
    )
    
    func sortWithTitle<Model: CoreDataMappable>(
        matching query: String?,
        completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    )
    
    func deleteTask<Model: CoreDataMappable>(
        withId id: Int,
        completionHandler: @escaping (Result<Model, CoreDataError>) -> Void
    )
}
