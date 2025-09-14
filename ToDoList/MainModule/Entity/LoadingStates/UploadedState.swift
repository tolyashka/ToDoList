//
//  UploadedState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import Foundation

final class UploadedState: TaskLoadingState {
    func execute(on output: InteractorOutput?) {
        DispatchQueue.main.async {
            output?.didFinishLoading()
        }
    }
}
