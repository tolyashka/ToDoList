//
//  TaskStateProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import UIKit

protocol TaskState {
    var iconName: String { get }
    var iconTint: UIColor { get }
    
    init(iconName: String, iconTint: UIColor)
    
    func apply(to label: UILabel, text: String)
    func apply(subtitle label: UILabel, text: String)
}


