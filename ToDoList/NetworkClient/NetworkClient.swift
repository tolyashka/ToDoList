//
//  NetworkService.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

protocol INetworkClient: AnyObject {
    func get<ResponseSchema>(
        completion: @escaping (Result<ResponseSchema, NetworkError>) -> Void)
    where ResponseSchema : Decodable
}

final class NetworkClient: NSObject {
    private let urlConfigurator: IURLConfigurator
    private lazy var jsonDecoder = JSONDecoder()
    private lazy var session: URLSession = {
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: nil
        )
        return session
    }()
    
    init(urlConfigurator: IURLConfigurator) {
        self.urlConfigurator = urlConfigurator
    }
}

extension NetworkClient: INetworkClient {
    func get<ResponseSchema>(
        completion: @escaping (Result<ResponseSchema, NetworkError>) -> Void) where ResponseSchema : Decodable {
        let url = urlConfigurator.url
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            if let data {
                do {
                    let result = try jsonDecoder.decode(ResponseSchema.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError()))
                }
                
            } else if let error {
                completion(.failure(.invalidResponse()))
            }
        }
        task.resume()
    }
}
