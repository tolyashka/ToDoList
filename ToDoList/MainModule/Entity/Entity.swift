//
//  Entity.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import CoreData

enum SectionModel: CaseIterable, Decodable {
    case main
}

struct ToDo: Decodable, Hashable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
    
    init(id: Int, todo: String, completed: Bool, userId: Int) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
}

extension ToDo: CoreDataMappable {
    init(entity: TaskEntity) {
        self.id = Int(entity.id)
        self.todo = entity.todo
        self.completed = entity.completed
        self.userId = Int(entity.userId)
    }
    
    func update(entity: TaskEntity) {
        entity.id = Int64(id)
        entity.todo = todo
        entity.completed = completed
        entity.userId = Int64(userId)
    }
}

struct ToDoModel: Decodable, Hashable {
    let todos: [ToDo]
}
