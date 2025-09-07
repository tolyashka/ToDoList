//
//  NewTaskPresenter.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 07.09.2025.
//

import UIKit

protocol NewTaskPresenterInput: AnyObject {
    func viewDidLoaded(_ view: NewTaskPresenterOutput)
}

protocol NewTaskPresenterOutput: AnyObject {
    
}

final class NewTaskPresenter: NewTaskPresenterInput {
    weak var view: NewTaskPresenterOutput?
    
    func viewDidLoaded(_ view: NewTaskPresenterOutput) {
        self.view = view
    }
}

//extension NewTaskPresenter: UITextViewDelegate {
//    
//}
