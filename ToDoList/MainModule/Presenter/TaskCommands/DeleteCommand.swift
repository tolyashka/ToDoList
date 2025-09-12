//
//  DeleteCommand.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 09.09.2025.
//

import UIKit

fileprivate struct Configurator {
    static let title = "Удалить"
    static let titleImage = "trash"
}

protocol TaskCommandProtocol: AnyObject {
    func deleteTask(with indexPath: IndexPath)
    func editTask(with indexPath: IndexPath)
    func shareTask(with indexPath: IndexPath)
}

struct DeleteCommand: TaskCommand {
    private weak var executor: TaskCommandProtocol?
    
    init(executor: TaskCommandProtocol?) {
        self.executor = executor
    }
    
    var attributes: UIMenuElement.Attributes {
        [.destructive]
    }
    
    private(set) var title: String = Configurator.title
    private(set) var image: UIImage? = UIImage(systemName: Configurator.titleImage)
    
    func execute(with indexPath: IndexPath) {
        executor?.deleteTask(with: indexPath)
    }
}
