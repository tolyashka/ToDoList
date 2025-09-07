//
//  LoadingStates.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

protocol TaskLoadingState {
    func execute(on output: InteractorOutput?)
}
