//
//  DataManagerProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

protocol ITaskFormDataManager: AnyObject {
    func update(
        for id: Int,
        with draft: TaskDraft
    )
    
    func saveNewTask(
        from draft: TaskDraft,
        completion: @escaping (Result<ToDo, CoreDataError>) -> Void
    )
}
