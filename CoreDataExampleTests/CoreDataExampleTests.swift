//
//  CoreDataExampleTests.swift
//  CoreDataExampleTests
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import XCTest
@testable import CoreDataExample

class CoreDataExampleTests: XCTestCase {

    let dataManager = DataManager.testing

    override class func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Starts_Empty() {
        let todos = dataManager.todos
        XCTAssertEqual(todos.count, 0)
    }
    
    func test_Add_Todo() {
        let todo = Todo()
        dataManager.updateAndSave(todo: todo)
        XCTAssertEqual(dataManager.todos.count, 1)
    }

}
