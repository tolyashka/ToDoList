//
//  CreateTaskModuleAssembly.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

final class CreateTaskModuleAssembly {
    func assembly() -> UIViewController {
        let presenter = NewTaskPresenter()
        let view = NewTaskViewController(presenter: presenter)
        return view
    }
}
