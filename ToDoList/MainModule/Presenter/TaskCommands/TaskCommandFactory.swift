//
//  TaskCommandFactory.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 09.09.2025.
//

import Foundation

protocol TaskCommandFactory {
    func makeCommands() -> [TaskCommand]
    func update(executor: TaskCommandProtocol)
}

final class DefaultCommandFactory: TaskCommandFactory {
    private weak var executor: TaskCommandProtocol?
    
    func update(executor: TaskCommandProtocol) {
        self.executor = executor
    }
    
    func makeCommands() -> [TaskCommand] {
        return [
            EditCommand(executor: executor),
            ShareCommand(executor: executor),
            DeleteCommand(executor: executor)
        ]
    }
}
