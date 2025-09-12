//
//  InteractorProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

protocol TaskFormInteractorInput: AnyObject {
    func save(task: TaskDraft)
    func update(for id: Int, with draft: TaskDraft)
}

protocol TaskFormInteractorOutput: AnyObject {
    func didFailSavingTask(error: CoreDataError)
}
