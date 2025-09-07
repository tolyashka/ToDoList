//
//  FailureUploadState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

final class FailureUploadState: TaskLoadingState {
    private let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func execute(on output: InteractorOutput?) {
        output?.didFailLoading(error: error)
    }
}
