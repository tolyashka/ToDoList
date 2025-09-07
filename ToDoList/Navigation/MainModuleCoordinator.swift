//
//  MainModuleCoordinator.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

final class MainModuleCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let assemblyCurrentModule: Assembly
    
    init(navigationController: UINavigationController, mainModuleAssembly: Assembly) {
        self.navigationController = navigationController
        self.assemblyCurrentModule = mainModuleAssembly
    }
    
    func start() {
        showModule()
    }
    
    func showNewTaskModule() {
        let assembly = CreateTaskModuleAssembly()
        let viewController = assembly.assembly()
        navigationController.pushViewController(viewController, animated: true)
    }
}

private extension MainModuleCoordinator {
    func showModule() {
        let viewController = assemblyCurrentModule.build()
        navigationController.pushViewController(viewController, animated: true)
    }
}
