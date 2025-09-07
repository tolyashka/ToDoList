//
//  Coordinator.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
}

protocol CoordinatorDetail: AnyObject {
    func showDetail(with url: String)
}

extension Coordinator {
    func finish() {
        _ = parentCoordinator?.childCoordinators.popLast()
        parentCoordinator = nil
    }
}
