//
//  CreateTaskModuleAssembly.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

final class TaskFormModuleAssembly {
    static func assemblyEditModule(with task: ToDo) -> UIViewController {
        let coreDataClient = CoreDataClient.shared
        let idGenerator = TaskIdGeneratorService()
        let dataManager = TaskFormDataManager(dataClient: coreDataClient, idGenerator: idGenerator)
        let repository = TaskFormRepository(dataManager: dataManager)
        let interactor = TaskFormInteractor(taskRepository: repository)
        let taskState = EditState(currentTask: task)
        let presenter = TaskFormPresenter(interactor: interactor, taskState: taskState)
        let view = TaskFormViewController(presenter: presenter)
        return view
    }
    
    static func assemblyCreateModule() -> UIViewController {
        let coreDataClient = CoreDataClient.shared
        let idGenerator = TaskIdGeneratorService()
        let dataManager = TaskFormDataManager(dataClient: coreDataClient, idGenerator: idGenerator)
        let repository = TaskFormRepository(dataManager: dataManager)
        let interactor = TaskFormInteractor(taskRepository: repository)
        let taskState = CreateState()
        let presenter = TaskFormPresenter(interactor: interactor, taskState: taskState)
        let view = TaskFormViewController(presenter: presenter)
        return view
    }
}
