//
//  interactorProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

protocol InteractorInput: AnyObject {
    var output: InteractorOutput? { get set }
    
    func changeState(with id: Int, newState: Bool)
    func filterTasks(with: String)
    func deleteTask(with id: Int)
    func fetchData()
}

protocol InteractorOutput: AnyObject {
    func didStartLoading()
    func didFinishLoading()
    func didFailLoading(error: Error)
    func didDelete(task: ToDo)
    func didLoadTasks(_ model: [ToDo])
}
