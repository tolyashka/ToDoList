//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

final class NetworkManager {
    typealias NetworkResult = Result<ToDoModel, NetworkError>
    
    private let networkClient: INetworkClient
    
    init(networkClient: INetworkClient) {
        self.networkClient = networkClient
    }
}

extension NetworkManager: INetworkManager {
    func fetchTasks(
        dataUploadingHandler: @escaping (LoadState) -> Void,
        completionHandler: @escaping (NetworkResult) -> Void
    ) {
        dataUploadingHandler(LoadState.beingUploaded)
        networkClient.get { (result: NetworkResult) in
            dataUploadingHandler(LoadState.uploaded)
            switch result {
            case .success(let questionModel):
                completionHandler(.success(questionModel))
            case .failure(let error):
                dataUploadingHandler(LoadState.uploadWithError(error))
            }
        }
    }
}
