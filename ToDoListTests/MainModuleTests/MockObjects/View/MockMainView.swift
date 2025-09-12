//
//  MockMainView.swift
//  ToDoListTests
//
//  Created by Анатолий Лушников on 11.09.2025.
//

import XCTest
@testable import ToDoList

final class MockMainView: MainViewInput {
    private(set) var didShowLoading = false
    private(set) var didHideLoading = false
    private(set) var didShowError: String?
    private(set) var didUpdateCounter: Int?

    func showLoading() {
        didShowLoading = true
    }
    
    func hideLoading() {
        didHideLoading = true
    }
    
    func showError(_ message: String) {
        didShowError = message
    }
    
    func updateCounter(count: Int) {
        didUpdateCounter = count
    }
}
