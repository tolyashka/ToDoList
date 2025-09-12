//
//  MockMainRouter.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import XCTest
@testable import ToDoList

final class MockRouter: MainPresenterInput {
    private(set) var didShowNewTaskModule = false
    private(set) var didShowEditTask: ToDo?

    func showNewTaskModule() {
        didShowNewTaskModule = true
    }
    
    func showEditTaskModule(with task: ToDo) {
        didShowEditTask = task
    }
}
