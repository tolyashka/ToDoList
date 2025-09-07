//
//  SelectedState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import UIKit

final class CompletedState: TaskState {
    let iconName: String
    let iconTint: UIColor
    
    init(iconName: String = "checkmark.circle",
         iconTint: UIColor = .systemYellow) {
        self.iconName = iconName
        self.iconTint = iconTint
    }
    
    func apply(to label: UILabel, text: String) {
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.selectedWhite
            ]
        )
        label.attributedText = attributedText
    }
    
    func apply(subtitle label: UILabel, text: String) {
        label.textColor = .selectedWhite
        label.text = text 
    }
}
