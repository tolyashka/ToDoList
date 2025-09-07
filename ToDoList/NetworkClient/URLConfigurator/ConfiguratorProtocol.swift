//
//  IURLConfigurator.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 06.09.2025.
//

import Foundation

protocol IURLConfigurator: AnyObject {
    var url: URL { get }
    
    func updateURL(with urlString: String) throws
    func updateURL(with url: URL)
}
