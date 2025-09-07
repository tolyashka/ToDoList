//
//  ManagerProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

protocol INetworkManager: AnyObject {
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (Result<ToDoModel, NetworkError>) -> Void
    )
}
