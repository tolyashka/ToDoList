//
//  CoreDataMappable.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import CoreData

protocol CoreDataMappable {
    associatedtype Entity: NSManagedObject
    
    init(entity: Entity)
    
    func update(entity: Entity)
}
