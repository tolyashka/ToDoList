//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

final class NewTaskViewController: UIViewController {
    private let presenter: NewTaskPresenterInput
    
    private let taskTextView: UITextView = {
        let textView = UITextView()
        textView.font = .title
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(presenter: NewTaskPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews() 
    }
    
    private func configureViews() {
        view.addSubview(taskTextView)
        setLayoutConstraints()
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            taskTextView.topAnchor.constraint(equalTo: view.topAnchor),
            taskTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
