//
//  NewTaskRepositoryProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import Foundation

protocol ITaskFormRepository {
    func update(
        for id: Int,
        with draft: TaskDraft
    )
    
    func saveNewTask(
        from draft: TaskDraft,
        completion: @escaping (Result<ToDo, CoreDataError>) -> Void
    )
}
