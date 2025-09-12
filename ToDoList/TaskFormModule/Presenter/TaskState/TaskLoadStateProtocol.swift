//
//  TaskEditorState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 10.09.2025.
//

import Foundation

protocol TaskLoadState: AnyObject {
    var defaultTitle: String? { get }
    func handleSave(text: String, presenter: TaskFormViewOutput)
}
