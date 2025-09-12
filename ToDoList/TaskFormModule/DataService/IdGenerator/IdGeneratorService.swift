//
//  IdGeneratorService.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 08.09.2025.
//

struct TaskIdGeneratorService {
    private let idOffset: Int
    
    init(idOffset: Int = 1) {
        self.idOffset = idOffset
    }
}

extension TaskIdGeneratorService: ITaskIdGeneratorService {
    func nextId(from currentMaxId: Int) -> Int {
        return currentMaxId + idOffset
    }
}
