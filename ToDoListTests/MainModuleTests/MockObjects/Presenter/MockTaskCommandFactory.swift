//
//  MockTaskCommandFactory.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import XCTest
@testable import ToDoList

struct EditCommandMock: TaskCommand {
    private let executor: TaskCommandProtocol?
    
    init(executor: TaskCommandProtocol?) {
        self.executor = executor
    }
    
    var attributes: UIMenuElement.Attributes {
        return []
    }
    
    private(set) var title = "test"
    private(set) var image: UIImage? = nil
    
    func execute(with indexPath: IndexPath) {
        executor?.editTask(with: indexPath)
    }
}


final class MockTaskCommandFactory: TaskCommandFactory {
    private let commands: [TaskCommand]

    init(commands: [TaskCommand] = [EditCommandMock(executor: MainPresenterTests() as! TaskCommandProtocol)]) {
        self.commands = commands
    }
    
    func makeCommands() -> [TaskCommand] {
        return commands
    }
    
    func update(executor: TaskCommandProtocol) {
        
    }
}
