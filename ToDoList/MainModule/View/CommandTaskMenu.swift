//
//  CommandTaskMenu.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 09.09.2025.
//

import UIKit

final class TaskCommandMenu: UIMenu {
    convenience init(
        title: String,
        image: UIImage? = nil,
        options: UIMenu.Options = [],
        commands: [TaskCommand],
        indexPath: IndexPath
    ) {
        let actions = commands.map { $0.toAction(with: indexPath) }
        self.init(title: title, image: image, identifier: nil, options: options, children: actions)
    }
}
