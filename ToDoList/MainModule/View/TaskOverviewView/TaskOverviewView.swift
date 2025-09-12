//
//  TaskOverviewView.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import UIKit

fileprivate struct Configurator {
    static let descriptionTitle = "Задачи не загружены"
    static let image = "square.and.pencil"
}
final class TaskOverviewView: UIView {
    weak var delegate: TaskOwerviewDelegate?
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = Configurator.descriptionTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createTaskImage: UIImageView = {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imageViewTapped)
        )
        
        let image = UIImage(systemName: Configurator.image)
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
        fatalError()
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
            createTaskImage.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8),
            createTaskImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            createTaskImage.widthAnchor.constraint(equalToConstant: 28),
            createTaskImage.heightAnchor.constraint(equalToConstant: 28),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: createTaskImage.leadingAnchor, constant: 10)
        ])
    }
}
