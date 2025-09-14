//
//  CoreDataService.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 04.09.2025.
//

import CoreData

fileprivate enum Key: String {
    case id
    case completed
}

fileprivate enum SortKey: String {
    case idDecimal = "id == %d"
    case idAll = "id == %@"
    case todoContains = "todo CONTAINS[cd] %@"
}

final class CoreDataClient {
    static var shared = CoreDataClient(modelName: CoreDataType.toDoList.rawValue)
    
    private let container: NSPersistentContainer
    
    private init(modelName: String = CoreDataType.toDoList.rawValue) {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in }
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
            try? context.save()
        }
    }
    
    func fetchTasks<Model: CoreDataMappable>(
        with completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    ) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<Model.Entity>(
                entityName: String(describing: Model.Entity.self)
            )
            request.sortDescriptors = [NSSortDescriptor(key: Key.id.rawValue, ascending: true)]
            
            do {
                let entities = try context.fetch(request)
                if entities.isEmpty {
                    DispatchQueue.main.async { completionHandler(.failure(.noData())) }
                    return
                }
                let models = entities.map { Model(entity: $0) }
                DispatchQueue.main.async { completionHandler(.success(models)) }
            } catch {
                DispatchQueue.main.async { completionHandler(.failure(.fetchFailed(error.localizedDescription))) }
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
            request.predicate = NSPredicate(format: SortKey.idDecimal.rawValue, id)
            request.fetchLimit = 1
            
            do {
                guard let entity = try context.fetch(request).first else {
                    completionHandler(.failure(.noData()))
                    return
                }
                
                entity.setValue(isCompleted, forKey: Key.completed.rawValue)
                try context.save()
                
                self.fetchTasks { result in
                    completionHandler(result)
                }
            } catch {
                completionHandler(.failure(.saveFailed(error.localizedDescription)))
            }
        }
    }
    
    func save<Model: CoreDataMappable>(
        task: Model,
        completionHandler: @escaping (Result<Model, CoreDataError>) -> Void
    ) {
        container.performBackgroundTask { context in
            let entity = Model.Entity(context: context)
            task.update(entity: entity)
            do {
                try context.save()
                DispatchQueue.main.async { completionHandler(.success(task)) }
            } catch {
                DispatchQueue.main.async { completionHandler(.failure(.saveFailed(error.localizedDescription))) }
            }
        }
    }
    
    func fetchLastTask<Model: CoreDataMappable>(
        completionHandler: @escaping (Result<Model, CoreDataError>) -> Void
    ) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<Model.Entity>(
                entityName: String(describing: Model.Entity.self)
            )
            request.sortDescriptors = [NSSortDescriptor(key: Key.id.rawValue, ascending: false)]
            request.fetchLimit = 1
            
            do {
                guard let entity = try context.fetch(request).first else {
                    DispatchQueue.main.async { completionHandler(.failure(.noData())) }
                    return
                }
                let model = Model(entity: entity)
                DispatchQueue.main.async { completionHandler(.success(model)) }
            } catch {
                DispatchQueue.main.async { completionHandler(.failure(.fetchFailed(error.localizedDescription))) }
            }
        }
    }
    
    func sortWithTitle<Model: CoreDataMappable>(
        matching query: String?,
        completionHandler: @escaping (Result<[Model], CoreDataError>) -> Void
    ) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<Model.Entity>(
                entityName: String(describing: Model.Entity.self)
            )
            request.sortDescriptors = [NSSortDescriptor(key: Key.id.rawValue, ascending: true)]
            
            if let query = query, !query.isEmpty {
                request.predicate = NSPredicate(format: SortKey.todoContains.rawValue, query)
            }
            
            do {
                let entities = try context.fetch(request)
                let models = entities.map { Model(entity: $0) }
                DispatchQueue.main.async { completionHandler(.success(models)) }
            } catch {
                DispatchQueue.main.async { completionHandler(.failure(.fetchFailed(error.localizedDescription))) }
            }
        }
    }
    
    func deleteTask<Model: CoreDataMappable>(
        withId id: Int,
        completionHandler: @escaping (Result<Model, CoreDataError>) -> Void
    ) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<Model.Entity>(entityName: String(describing: Model.Entity.self))
            request.predicate = NSPredicate(format: SortKey.idAll.rawValue, NSNumber(value: id))
            request.fetchLimit = 1
            
            do {
                if let entity = try context.fetch(request).first {
                    context.delete(entity)
                    try context.save()
                    DispatchQueue.main.async { completionHandler(.success(Model(entity: entity))) }
                } else {
                    DispatchQueue.main.async { completionHandler(.failure(.noData())) }
                }
            } catch {
                DispatchQueue.main.async { completionHandler(.failure(.saveFailed(error.localizedDescription))) }
            }
        }
    }
    
    func update<Draft: CoreDataDraft>(for id: Int, with draft: Draft) {
        let entityName = String(describing: Draft.Entity.self)
        let fetchRequest = NSFetchRequest<Draft.Entity>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: SortKey.idDecimal.rawValue, id)
        fetchRequest.fetchLimit = 1
        
        guard let entity = try? viewContext.fetch(fetchRequest).first else { return }
        draft.apply(to: entity)
        
        if viewContext.hasChanges { try? viewContext.save() }
    }
}
