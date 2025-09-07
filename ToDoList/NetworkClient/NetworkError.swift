//
//  NetworkError.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

enum NetworkError: Error {
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(let message),
             .invalidResponse(let message),
             .decodingError(let message):
            return message
        }
    }
}
