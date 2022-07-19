//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import XCTest
@testable import CoreDataExample

class DataManagerTests: XCTestCase {

    var dataManager: DataManager!

    override func setUp() {
        super.setUp()
         let testBundle = Bundle(for: type(of: self))
         let modelUrl = testBundle.url(forResource: "CoreDataModel", withExtension: "momd")
         dataManager = DataManager(type: .testing, modelUrl: modelUrl)
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
