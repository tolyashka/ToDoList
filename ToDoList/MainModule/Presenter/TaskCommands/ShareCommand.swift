//
//  ShareCommand.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 09.09.2025.
//

import UIKit

fileprivate struct Configurator {
    static let title = "Поделиться"
    static let titleImage = "square.and.arrow.up"
}

struct ShareCommand: TaskCommand {
    private weak var executor: TaskCommandProtocol?
    
    init(executor: TaskCommandProtocol?) {
        self.executor = executor
    }
    
    var attributes: UIMenuElement.Attributes {
        return []
    }
    
    private(set) var title: String = Configurator.title
    private(set) var image: UIImage? = UIImage(systemName: Configurator.titleImage)
    
    func execute(with indexPath: IndexPath) {
        executor?.shareTask(with: indexPath)
    }
}
