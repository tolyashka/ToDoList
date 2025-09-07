//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 04.09.2025.
//

import CoreData

final class CoreDataClient<Model: CoreDataMappable> {
    
    private let container: NSPersistentContainer
    
    init(modelName: String = "ToDoList") {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private var viewContext: NSManagedObjectContext {
        container.viewContext
    }
}

extension CoreDataClient: ICoreDataClient {
    func save<Model: CoreDataMappable>(tasks: [Model]) {
        container.performBackgroundTask { context in
            tasks.forEach { task in
                let entity = Model.Entity(context: context)
                task.update(entity: entity)
            }
            do {
                try context.save()
            } catch {
                print("save error")
            }
        }
    }
    
    func fetchTasks<Model: CoreDataMappable>(
        with completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    ) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<Model.Entity>(
                entityName: String(describing: Model.Entity.self)
            )
            
            request.sortDescriptors = [
                NSSortDescriptor(key: "id", ascending: true)
            ]
            
            do {
                let entities = try context.fetch(request)
                if entities.isEmpty {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.noData()))
                    }
                    return
                }
                
                let models = entities.map { Model(entity: $0) }
                DispatchQueue.main.async {
                    completionHandler(.success(models))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.fetchFailed(error.localizedDescription)))
                }
            }
        }
    }
    
    func updateCompletedState<Model: CoreDataMappable>(
            for id: Int,
            isCompleted: Bool,
            completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
        ) {
            container.performBackgroundTask { context in
                let request = NSFetchRequest<Model.Entity>(
                    entityName: String(describing: Model.Entity.self)
                )
                request.predicate = NSPredicate(format: "id == %d", id)
                request.fetchLimit = 1
                
                do {
                    guard let entity = try context.fetch(request).first else {
                        completionHandler(.failure(.noData()))
                        return
                    }
                    
                    entity.setValue(isCompleted, forKey: "completed")
                    try context.save()
                    
                    self.fetchTasks { result in
                        completionHandler(result)
                    }
                    
                } catch {
                    completionHandler(.failure(.saveFailed(error.localizedDescription)))
                }
            }
        }
}
