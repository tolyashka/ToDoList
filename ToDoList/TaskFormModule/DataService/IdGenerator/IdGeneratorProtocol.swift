//
//  IdGeneratorProtocol.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import Foundation

protocol ITaskIdGeneratorService {
    func nextId(from currentMaxId: Int) -> Int
}
