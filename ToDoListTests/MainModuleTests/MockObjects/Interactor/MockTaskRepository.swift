//
//  MockTaskRepository.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 12.09.2025.
//

import XCTest
@testable import ToDoList

final class MockTaskRepository: ITaskRepository {
    var fetchTasksResult: Result<[ToDo], Error>?
    var updateStateResult: Result<[ToDo], CoreDataError>?
    var filterTasksResult: Result<[ToDo], CoreDataError>?
    var deleteTaskResult: Result<ToDo, CoreDataError>?

    private(set) var fetchTasks = false
    private(set) var updateState = false
    private(set) var filterTasks = false
    private(set) var deleteTask = false
    
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], Error>) -> Void
    ) {
        fetchTasks = true
        if let fetchTasksResult {
            completionHandler(fetchTasksResult)
        }
    }

    func updateState(
        for id: Int,
        newState: Bool,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void
    ) {
        updateState = true
        if let updateStateResult {
            completionHandler(updateStateResult)
        }
    }

    func sortWithTitle(
        matching query: String?,
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<[ToDo], CoreDataError>) -> Void
    ) {
        filterTasks = true
        if let filterTasksResult {
            completionHandler(filterTasksResult)
        }
    }

    func delete(
        with id: Int,
        completionHandler: @escaping (Result<ToDo, CoreDataError>) -> Void
    ) {
        deleteTask = true
        if let deleteTaskResult {
            completionHandler(deleteTaskResult)
        }
    }
}
