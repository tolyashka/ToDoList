//
//  CreateState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

final class CreateState: TaskLoadState {
    var defaultTitle: String? {
        return nil
    }
    
    func handleSave(text: String, presenter: TaskFormViewOutput) {
        presenter.saveTask(withTitle: text)
    }
}
