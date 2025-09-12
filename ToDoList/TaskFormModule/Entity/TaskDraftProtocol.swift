//
//  TaskDraftProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import CoreData

protocol CoreDataDraft {
    associatedtype Entity: NSManagedObject
    func apply(to entity: Entity)
}
