//
//  UIFont+titles.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import UIKit

extension UIFont {
    static var title: UIFont? {
        .systemFont(ofSize: 22, weight: .bold)
    }
    
    static var subTitle: UIFont? {
        .systemFont(ofSize: 16, weight: .regular)
    }
}
