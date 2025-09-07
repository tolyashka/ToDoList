//
//  Router.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

protocol IMainModuleRouter: AnyObject {
    func pushToCreateTask()
}

final class MainModuleRouter: IMainModuleRouter {
    var navigationController: UINavigationController?
    
    func pushToCreateTask() {
        let createTaskAssembly = CreateTaskModuleAssembly()
        let viewController = createTaskAssembly.assembly()
        print("++", navigationController)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
