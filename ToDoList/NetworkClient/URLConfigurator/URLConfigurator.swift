//
//  URLConfigurator.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import Foundation

final class URLConfigurator {
    private(set) var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    convenience init(urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw URLConfiguratorError.invalidURL()
        }
        self.init(url: url)
    }
}

extension URLConfigurator: IURLConfigurator {
    func updateURL(with urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw URLConfiguratorError.invalidURL()
        }
        
        self.url = url
    }
    
    func updateURL(with url: URL) {
        self.url = url
    }
}
