//
//  Router.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

final class MainModuleRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension MainModuleRouter: MainPresenterInput {
    func showNewTaskModule() {
        let newTaskViewController = TaskFormModuleAssembly.assemblyCreateModule()
        viewController?.navigationController?.pushViewController(newTaskViewController, animated: true)
    }
    
    func showEditTaskModule(with task: ToDo) {
        let editTaskViewController = TaskFormModuleAssembly.assemblyEditModule(with: task)
        viewController?.navigationController?.pushViewController(editTaskViewController, animated: true)
    }
}
