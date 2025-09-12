//
//  PresenterProtocols.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

protocol MainPresenterInput: AnyObject {
    func showNewTaskModule()
    func showEditTaskModule(with task: ToDo)
}
