//
//  MainModuleInteractorTests.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 12.09.2025.
//

import XCTest
@testable import ToDoList

final class MainModuleInteractorTests: XCTestCase {
    private var sut: MainModuleInteractor!
    private var mockRepository: MockTaskRepository!
    private var mockPresenter: MockMainPresenter!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockTaskRepository()
        sut = MainModuleInteractor(taskRepository: mockRepository)
        mockPresenter = MockMainPresenter()
        sut.output = mockPresenter
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func test_fetchData_failure() {
        let expectedError = NSError(domain: "Test", code: 1)
        mockRepository.fetchTasksResult = .failure(expectedError)
        sut.fetchData()
        
        XCTAssertTrue(mockPresenter.actions.contains(.didFailLoading(expectedError.localizedDescription)))
    }
    
    func test_changeState_success() {
        let expectedTasks = [ToDo(id: 1, todo: "Task", completed: true, userId: 1)]
        mockRepository.updateStateResult = .success(expectedTasks)
        sut.changeState(with: 1, newState: true)
        
        XCTAssertEqual(mockPresenter.actions, [.didLoadTasks(expectedTasks)])
    }
    
    func test_changeState_failure() {
        let expectedError = CoreDataError.saveFailed("Failed")
        mockRepository.updateStateResult = .failure(expectedError)
        sut.changeState(with: 1, newState: true)
        
        XCTAssertEqual(mockPresenter.actions, [.didFailLoading(expectedError.localizedDescription)])
    }
    
    func test_filterTasks_success() {
        let expectedTasks = [ToDo(id: 2, todo: "Filter", completed: false, userId: 1)]
        mockRepository.filterTasksResult = .success(expectedTasks)
        sut.filterTasks(with: "Filter")
    
        XCTAssertTrue(mockPresenter.actions.contains(.didLoadTasks(expectedTasks)))
    }
    
    func test_deleteTask_failure() {
        let expectedError = CoreDataError.noData()
        mockRepository.deleteTaskResult = .failure(expectedError)
        sut.deleteTask(with: 1)
        
        XCTAssertEqual(mockPresenter.actions, [.didFailLoading(expectedError.localizedDescription)])
    }
}
