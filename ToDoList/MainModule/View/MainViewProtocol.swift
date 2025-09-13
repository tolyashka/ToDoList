//
//  MainViewProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import UIKit

protocol MainViewInput: AnyObject {
    func showLoading()
    func hideLoading()
    func updateCounter(count: Int)
    func showError(_ message: String)
}

protocol MainViewOutput: AnyObject {
    func createTask()
    func viewDidAppearing()
    func viewDidLoaded(view: MainViewInput)
    func filterTasks(with query: String)
    func makeContextMenu(with indexPath: IndexPath) -> UIMenu
    func configureDataSource(for tableView: UITableView)
}
