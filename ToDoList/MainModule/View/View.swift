//
//  ViewController.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

protocol IView: AnyObject {
    func showLoading()
    func hideLoading()
    func updateCounter(count: Int)
    func showError(_ message: String)
}

class ViewController: UIViewController {
    private let presenter: MainPresenterInput
    
    private lazy var taskOverviewView: TaskOverviewView = {
        let customView = TaskOverviewView()
        customView.delegate = self
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    private lazy var taskTableView: TaskTableView = {
        let tableView = TaskTableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemRed
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    init(presenter: MainPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoaded(view: self)
        presenter.configureDataSource(for: taskTableView)
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(activityIndicator)
        view.addSubview(taskTableView)
        view.addSubview(taskOverviewView)
        
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

extension ViewController: IView {
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
            let alert = UIAlertController(
                title: "Ошибка",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            present(alert, animated: true)
        }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRow
    }
}

extension ViewController: TaskOwerviewDelegate {
    func createTask() {
        presenter.createTask()
    }
}
