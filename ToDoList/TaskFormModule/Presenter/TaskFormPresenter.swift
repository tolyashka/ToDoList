//
//  NewTaskPresenter.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

final class TaskFormPresenter {
    private let interactor: TaskFormInteractorInput
    private let taskState: TaskLoadState
    private weak var view: TaskFormViewInput?
    
    init(interactor: TaskFormInteractorInput, taskState: TaskLoadState) {
        self.interactor = interactor
        self.taskState = taskState
    }
}

extension TaskFormPresenter: TaskFormViewOutput {
    func viewDidLoaded(_ view: TaskFormViewInput) {
        self.view = view
        self.view?.setConfiguration(with: taskState.defaultTitle)
    }
    
    func saveTask(withTitle title: String) {
        guard !(title.isEmpty) else { return }
        let task = TaskDraft(todo: title)
        interactor.save(task: task)
    }
    
    func updateTask(for id: Int, withTitle title: String) {
        guard !(title.isEmpty) else { return }
        let task = TaskDraft(todo: title)
        interactor.update(for: id, with: task)
    }
    
    func saveContext(with title: String) {
        taskState.handleSave(text: title, presenter: self)
    }
}
