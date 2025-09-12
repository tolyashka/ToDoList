//
//  TaskCommandProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 09.09.2025.
//

import UIKit

protocol TaskCommand {
    init(executor: TaskCommandProtocol?)
    
    var title: String { get }
    var image: UIImage? { get }
    var attributes: UIMenuElement.Attributes { get }
    func execute(with: IndexPath)
}

extension TaskCommand {
    func toAction(with indexPath: IndexPath) -> UIAction {
        return UIAction(title: title, image: image, attributes: attributes) { _ in
            execute(with: indexPath)
        }
    }
}
