//
//  DiffableDataSource.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

final class TaskDataSource<Cell: UITableViewCell>:
    UITableViewDiffableDataSource<SectionModel, ToDo> {

    var count: Int {
        var snapshot = self.snapshot()
        return snapshot.numberOfItems
    }
    
    init(tableView: UITableView,
         cellCompletion: @escaping (Cell, IndexPath, ToDo) -> Void) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Cell.identifier,
                for: indexPath
            ) as? Cell else {
                return UITableViewCell()
            }
            
            cellCompletion(cell, indexPath, itemIdentifier)
            return cell
        }
    }
    
    func apply(with items: [ToDo], animated animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionModel, ToDo>()
        snapshot.appendSections(SectionModel.allCases)
        snapshot.appendItems(items, toSection: .main)
        apply(snapshot, animatingDifferences: animate)
    }
    
    func delete(with item: ToDo) {
        var snapshot = self.snapshot()
        if snapshot.indexOfItem(item) != nil {
            snapshot.deleteItems([item])
            apply(snapshot, animatingDifferences: false)
        }
    }
}
