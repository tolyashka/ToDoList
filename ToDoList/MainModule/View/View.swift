//
//  ViewController.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

fileprivate struct Configurator {
    static let title = "Мои задачи"
    static let searchBar = "Поиск задачи"
}

final class MainViewController: UIViewController {
    private let presenter: MainViewOutput
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var taskOverviewView: TaskOverviewView = {
        let customView = TaskOverviewView()
        customView.delegate = self
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    private lazy var taskTableView: TaskTableView = {
        let tableView = TaskTableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemRed
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    init(presenter: MainViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        presenter.configureDataSource(for: taskTableView)
        presenter.viewDidLoaded(view: self)
        configureViews()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppearing()
    }
}

extension MainViewController: MainViewInput {
    func updateCounter(count: Int) {
        taskOverviewView.updateTask(count: count)
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
        
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
        
    func showError(_ message: String) {
        // FIXME: Переделать
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.lowercased() else { return }
        presenter.filterTasks(with: query)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            self.presenter.makeContextMenu(with: indexPath)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        willPerformPreviewAction action: UIPreviewActionItem,
        forRowAt indexPath: IndexPath) -> UITableView.RowAnimation {
            return .none
    }
}

extension MainViewController: TaskOwerviewDelegate {
    func createTask() {
        presenter.createTask()
    }
}

private extension MainViewController {
    func configureNavigationBar() {
        title = Configurator.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Configurator.searchBar
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureViews() {
        view.addSubview(taskTableView)
        view.addSubview(taskOverviewView)
        view.addSubview(activityIndicator)

        setLayoutConstraints()
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            taskOverviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskOverviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskOverviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskOverviewView.heightAnchor.constraint(equalToConstant: 83),
            
            taskTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: taskOverviewView.topAnchor),
        ])
    }
}
