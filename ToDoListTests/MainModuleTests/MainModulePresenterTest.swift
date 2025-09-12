//
//  MainModulePresenterTest.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import XCTest
@testable import ToDoList

final class MainPresenterTests: XCTestCase {
    private var presenter: MainPresenter!
    private var mockView: MockMainView!
    private var mockInteractor: MockMainInteractor!
    private var mockRouter: MockRouter!
    private var mockCommandFactory: MockTaskCommandFactory!

    override func setUp() {
        super.setUp()
        mockView = MockMainView()
        mockInteractor = MockMainInteractor()
        mockRouter = MockRouter()
        mockCommandFactory = MockTaskCommandFactory()
        presenter = MainPresenter(interactor: mockInteractor, taskCommand: mockCommandFactory)
        presenter.change(router: mockRouter)
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        mockCommandFactory = nil
        super.tearDown()
    }

    func test_viewDidLoaded() {
        presenter.viewDidLoaded(view: mockView)
        XCTAssertTrue(mockInteractor.output is MainPresenter)
        XCTAssertTrue(presenter.view === mockView)
    }

    func test_viewWillAppearing() {
        presenter.viewWillAppearing()
        XCTAssertTrue(mockInteractor.didFetchData)
    }

    func test_changeState() {
        presenter.changeState(with: 1, newState: true)
        XCTAssertEqual(mockInteractor.didChangeState?.id, 1)
        XCTAssertEqual(mockInteractor.didChangeState?.newState, true)
    }

    func test_createTask() {
        presenter.createTask()
        XCTAssertTrue(mockRouter.didShowNewTaskModule)
    }

    func test_didStartLoading() {
        presenter.viewDidLoaded(view: mockView)
        presenter.didStartLoading()
        XCTAssertTrue(mockView.didShowLoading)
    }

    func test_didFinishLoading() {
        presenter.viewDidLoaded(view: mockView)
        presenter.didFinishLoading()
        XCTAssertTrue(mockView.didHideLoading)
    }

    func test_didFailLoading() {
        presenter.viewDidLoaded(view: mockView)
        presenter.didFailLoading(error: NSError(domain: "test", code: 1))
        XCTAssert(mockView.didShowError != nil)
    }

    func test_didLoadTasks() {
        presenter.viewDidLoaded(view: mockView)
        let todos = [ToDo(id: 1, todo: "task", completed: false, userId: 1)]
        presenter.didLoadTasks(todos)
        XCTAssertEqual(mockView.didUpdateCounter, todos.count)
    }
}

extension MainPresenterTests: TaskCommandProtocol {
    func deleteTask(with indexPath: IndexPath) {
        mockInteractor?.deleteTask(with: indexPath.row)
    }
    
    func editTask(with indexPath: IndexPath) {
        
    }
    
    func shareTask(with indexPath: IndexPath) {
        
    }
}
