//
//  IncompleteState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import UIKit

fileprivate struct Configurator {
    static let iconName: String = "circle"
    static let iconTint: UIColor = .gray
}

final class IncompleteState: TaskState {
    var iconName: String
    var iconTint: UIColor
    
    init(iconName: String = Configurator.iconName,
         iconTint: UIColor = Configurator.iconTint) {
        self.iconName = iconName
        self.iconTint = iconTint
    }
    
    func apply(to label: UILabel, text: String) {
        label.attributedText = nil
        label.text = text
        label.textColor = .defaultWhite
    }
    
    func apply(subtitle label: UILabel, text: String) {
        label.text = text
        label.textColor = .defaultWhite
    }
}
