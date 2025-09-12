//
//  EditCommand.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 09.09.2025.
//

import UIKit

fileprivate struct Configurator {
    static let title = "Редактировать"
    static let titleImage = "pencil"
}


struct EditCommand: TaskCommand {
    private weak var executor: TaskCommandProtocol?
    
    init(executor: TaskCommandProtocol?) {
        self.executor = executor
    }
    
    var attributes: UIMenuElement.Attributes {
        return []
    }
    
    private(set) var title = Configurator.title
    private(set) var image: UIImage? = UIImage(systemName: Configurator.titleImage)
    
    func execute(with indexPath: IndexPath) {
        executor?.editTask(with: indexPath)
    }
}
