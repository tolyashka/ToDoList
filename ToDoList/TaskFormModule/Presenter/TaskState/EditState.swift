//
//  File.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

final class EditState: TaskLoadState {
    var defaultTitle: String? {
        currentTask.todo
    }
    
    private let currentTask: ToDo

    init(currentTask: ToDo) {
        self.currentTask = currentTask
    }
    
    func handleSave(text: String, presenter: TaskFormViewOutput) {
        presenter.updateTask(for: currentTask.id, withTitle: text)
    }
}
