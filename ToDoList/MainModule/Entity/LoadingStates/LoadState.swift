//
//  LoadState.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

enum LoadState {
    case beingUploaded
    case uploaded
    case uploadWithError(Error)
}
