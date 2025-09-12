//
//  MockPresenter.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 12.09.2025.
//

import XCTest
@testable import ToDoList

final class MockMainPresenter: InteractorOutput {
    enum Action: Equatable {
        case didStartLoading
        case didFinishLoading
        case didFailLoading(String)
        case didLoadTasks([ToDo])
    }
    
    private(set) var actions: [Action] = []
    
    func didStartLoading() {
        actions.append(.didStartLoading)
    }
    
    func didFinishLoading() {
        actions.append(.didFinishLoading)
    }
    
    func didFailLoading(error: Error) {
        actions.append(.didFailLoading(error.localizedDescription))
    }
    
    func didLoadTasks(_ model: [ToDo]) {
        actions.append(.didLoadTasks(model))
    }
}

