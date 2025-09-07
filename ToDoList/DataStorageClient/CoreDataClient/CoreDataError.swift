//
//  CoreDataError.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 04.09.2025.
//

import Foundation

enum CoreDataError: Error {
    case noData(String = "There is no saved data")
    case saveFailed(String = "Data saving error")
    case fetchFailed(String = "Error fetching data")
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData(let message),
             .saveFailed(let message),
             .fetchFailed(let message):
            return message
        }
    }
}
