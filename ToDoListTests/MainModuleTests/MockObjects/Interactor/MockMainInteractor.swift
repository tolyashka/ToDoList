//
//  MockMainInteractor.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import XCTest
@testable import ToDoList

final class MockMainInteractor: InteractorInput {
    weak var output: InteractorOutput?
    
    private(set) var didFetchData = false
    private(set) var didChangeState: (id: Int, newState: Bool)?
    private(set) var didFilterTasks: String?
    private(set) var didDeleteTask: Int?
    
    func fetchData() {
        didFetchData = true
    }
    
    func changeState(with id: Int, newState: Bool) {
        didChangeState = (id, newState)
    }
    
    func filterTasks(with query: String) {
        didFilterTasks = query
    }
    
    func deleteTask(with id: Int) {
        didDeleteTask = id
    }
}
