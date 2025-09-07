//
//  UploadedState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

final class UploadedState: TaskLoadingState {
    func execute(on output: InteractorOutput?) {
        output?.didFinishLoading()
    }
}
