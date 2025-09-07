//
//  MainModuleAssembly.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

protocol Assembly: AnyObject {
    func build() -> UIViewController
}

final class AssemblyMainModule: Assembly {
    func build() -> UIViewController {
        guard let url = URL(string: "https://dummyjson.com/todos") else { return UIViewController() }
        let urlConfigurator = URLConfigurator(url: url)
        let networkClient = NetworkClient(urlConfigurator: urlConfigurator)
        let networkManager = NetworkManager(networkClient: networkClient)
        let coreDataClient = CoreDataClient<ToDo>()
        let coreDataManager = CoreDataManager(coreDataClient: coreDataClient)
        let taskRepository = TaskRepository(networkManager: networkManager, localManager: coreDataManager)
        let interactor = Interactor(taskRepository: taskRepository)
        let router = MainModuleRouter()
        let presenter = MainPresenter(interactor: interactor)
        let viewController = ViewController(presenter: presenter)
        return viewController
    }
}
