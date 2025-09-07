//
//  TaskEntity.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 04.09.2025.
//

import Foundation
import CoreData

@objc(TaskEntity)
public class TaskEntity: NSManagedObject {
    @NSManaged public var id: Int64
    @NSManaged public var todo: String
    @NSManaged public var completed: Bool
    @NSManaged public var userId: Int64
}

extension TaskEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }
}
