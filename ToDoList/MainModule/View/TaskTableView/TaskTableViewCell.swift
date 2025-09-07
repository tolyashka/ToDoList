//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

extension UIFont {
    static var title: UIFont? {
        .systemFont(ofSize: 22, weight: .bold)
    }
    
    static var subTitle: UIFont? {
        .systemFont(ofSize: 16, weight: .regular)
    }
}

extension UIColor {
    static var selectedWhite: UIColor {
        UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.5)
    }
    
    static var defaultWhite: UIColor {
        UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    }
}

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

final class TaskTableViewCell: UITableViewCell {
    var isCompleted: (() -> Void)?
    
    private var state: TaskState?
    
    private lazy var statusImageView: UIImageView = {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(changeCompletionStatus)
        )
        
        let imageView = UIImageView()
        imageView.addGestureRecognizer(tapGesture)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .subTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateValue(with model: ToDo) {
        state = model.completed ? CompletedState() : IncompleteState()
        guard let state else { return }
        statusImageView.image = UIImage(systemName: state.iconName)
        statusImageView.tintColor = state.iconTint
        state.apply(to: titleLabel, text: model.todo)
        state.apply(subtitle: subTitleLabel, text: model.todo)
    }
    
    @objc private func changeCompletionStatus() {
        isCompleted?()
    }
    
    private func configureViews() {
        contentView.addSubview(statusImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            statusImageView.widthAnchor.constraint(equalToConstant: 24),
            statusImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subTitleLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 12),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
