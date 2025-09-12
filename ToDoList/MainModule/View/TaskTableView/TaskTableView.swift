//
//  TaskTableView.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

final class TaskTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureCell() {
        self.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
    }
}
