//
//  URLConfiguratorPorotocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import Foundation

enum URLConfiguratorError: Error {
    case invalidURL(String = "Invalid URL")
}

extension URLConfiguratorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL(let message):
            return message
        }
    }
}
