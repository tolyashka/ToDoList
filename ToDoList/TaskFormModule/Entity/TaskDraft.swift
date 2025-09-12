//
//  TaskDraft.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

struct TaskDraft {
    let todo: String
}

extension TaskDraft: CoreDataDraft {
    typealias Entity = TaskEntity
    
    func apply(to entity: TaskEntity) {
        entity.todo = todo
    }
}
