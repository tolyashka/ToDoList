//
//  Presenter.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit
fileprivate struct Configurator {
    static let menuTitle = "Действия"
}

final class MainPresenter {
    weak var view: MainViewInput?
    private var diffableDataSource: TaskDataSource<TaskTableViewCell>?
    private var router: MainPresenterInput?
    private let interactor: InteractorInput
    private let taskCommandFactory: TaskCommandFactory
    
    private lazy var taskCommand = taskCommandFactory.makeCommands()
    
    init(interactor: InteractorInput, taskCommand: TaskCommandFactory) {
        self.interactor = interactor
        self.taskCommandFactory = taskCommand
    }
    
    func change(router: MainPresenterInput) {
        self.router = router
    }
}

extension MainPresenter: MainViewOutput {
    func viewDidLoaded(view: MainViewInput) {
        self.view = view
        self.interactor.output = self
    }
    
    func viewDidAppearing() {
        interactor.fetchData()
    }
    
    func configureDataSource(for tableView: UITableView) {
        diffableDataSource = TaskDataSource(
        tableView: tableView) { cell, indexPath, model in
            cell.updateValue(with: model)
            cell.isCompleted = { [weak self] in
                self?.changeState(with: model.id, newState: !model.completed)
            }
        }
    }
    
    func changeState(with id: Int, newState: Bool) {
        interactor.changeState(with: id, newState: newState)
    }
    
    func createTask() {
        router?.showNewTaskModule()
    }
    
    func filterTasks(with query: String) {
        interactor.filterTasks(with: query)
    }
}

extension MainPresenter: InteractorOutput {
    func didDelete(task: ToDo) {
        diffableDataSource?.delete(with: task)
        guard let count = diffableDataSource?.count else { return }
        view?.updateCounter(count: count)
    }
    
    func didStartLoading() {
        view?.showLoading()
    }
    
    func didFinishLoading() {
        view?.hideLoading()
    }
    
    func didFailLoading(error: Error) {
        view?.showError(error.localizedDescription)
    }
    
    func didLoadTasks(_ model: [ToDo]) {
        view?.updateCounter(count: model.count)
        diffableDataSource?.apply(with: model, animated: false)
    }
    
    func makeContextMenu(with indexPath: IndexPath) -> UIMenu {
        return TaskCommandMenu(
            title: Configurator.menuTitle,
            commands: taskCommand,
            indexPath: indexPath
        )
    }
}

extension MainPresenter: TaskCommandProtocol {
    func editTask(with indexPath: IndexPath) {
        guard let task = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        router?.showEditTaskModule(with: task)
    }
    
    func shareTask(with indexPath: IndexPath) {
        print("SHARE")
    }
    
    func deleteTask(with indexPath: IndexPath) {
        guard let task = diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        interactor.deleteTask(with: task.id)
    }
}
