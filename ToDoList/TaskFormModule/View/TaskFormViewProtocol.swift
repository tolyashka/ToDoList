//
//  NewTaskViewProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import Foundation

protocol TaskFormViewInput: AnyObject {
    func setConfiguration(with title: String?)
}

protocol TaskFormViewOutput: AnyObject {
    func viewDidLoaded(_ view: TaskFormViewInput)
    func updateTask(for id: Int, withTitle title: String)
    func saveContext(with title: String)
    func saveTask(withTitle title: String)
}
