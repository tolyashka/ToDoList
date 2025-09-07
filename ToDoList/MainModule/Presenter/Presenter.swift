//
//  Presenter.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

protocol MainPresenterInput: AnyObject {
    var heightForRow: CGFloat { get }
    
    func createTask()
    func configureDataSource(for tableView: UITableView)
    func changeState(with id: Int, newState: Bool)
    func viewDidLoaded(view: IView)
}

final class MainPresenter {
    weak var view: IView?
    private var diffableDataSource: TaskDataSource<TaskTableViewCell>?
    private let interactor: InteractorInput
    
    init(interactor: InteractorInput, coordinator: Coordinator) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

extension MainPresenter: MainPresenterInput {
    var heightForRow: CGFloat {
        120.0
    }
        
    func viewDidLoaded(view: IView) {
        self.view = view
        self.interactor.output = self
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
        print("--")
        let coordinator = coordinator as? MainModuleCoordinator
        coordinator?.showNewTaskModule()
    }
}

extension MainPresenter: InteractorOutput {
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
}
