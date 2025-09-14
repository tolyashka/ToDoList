//
//  FailureUploadState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import Foundation

final class FailureUploadState: TaskLoadingState {
    private let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func execute(on output: InteractorOutput?) {
        DispatchQueue.main.async {
            output?.didFailLoading(error: self.error)
        }
    }
}
