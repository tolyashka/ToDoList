//
//  TaskOverviewView.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import UIKit

protocol TaskOwerviewDelegate: AnyObject {
    func createTask()
}

final class TaskOverviewView: UIView {
    weak var delegate: TaskOwerviewDelegate?
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Задачи не загружены"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createTaskImage: UIImageView = {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imageViewTapped)
        )
        
        let image = UIImage(systemName: "square.and.pencil")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemYellow
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(tapGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTask(count: Int) {
        DispatchQueue.main.async {
            self.descriptionLabel.text = "\(count) задач"
        }
    }
    
    @objc private func imageViewTapped() {
        delegate?.createTask()
    }
}

private extension TaskOverviewView {
    func configureViews() {
        self.backgroundColor = .darkGray
        
        self.addSubview(descriptionLabel)
        self.addSubview(createTaskImage)
        setLayoutConstraints()
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            createTaskImage.topAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -8),
            createTaskImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            createTaskImage.widthAnchor.constraint(equalToConstant: 28),
            createTaskImage.heightAnchor.constraint(equalToConstant: 28),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: createTaskImage.leadingAnchor, constant: 10)
        ])
    }
}
