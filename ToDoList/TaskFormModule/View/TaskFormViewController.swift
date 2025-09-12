//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

final class TaskFormViewController: UIViewController {
    private let presenter: TaskFormViewOutput
    
    private let taskTextView: UITextView = {
        let textView = UITextView()
        textView.font = .title
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(presenter: TaskFormViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoaded(self)
        configureViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.saveContext(with: taskTextView.text)
    }
}

extension TaskFormViewController: TaskFormViewInput {
    func setConfiguration(with title: String?) {
        taskTextView.text = title
    }
}

private extension TaskFormViewController {
    func configureViews() {
        view.addSubview(taskTextView)
        setLayoutConstraints()
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            taskTextView.topAnchor.constraint(equalTo: view.topAnchor),
            taskTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
