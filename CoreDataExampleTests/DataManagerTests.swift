//
//  DataManagerTests.swift
//  DataManagerTests
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import XCTest

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
    
    func test_StartsEmpty() {
        let todos = dataManager.todos
        let projects = dataManager.projects
        XCTAssertEqual(todos.count, 0)
        XCTAssertEqual(projects.count, 0)
    }
    
    //MARK: - Todo
    func test_AddNewTodo() {
        let todo = Todo()
        dataManager.updateAndSave(todo: todo)
        XCTAssertEqual(dataManager.todos.count, 1)
    }
    
    func test_UpdateTodo() {
        var todo = Todo()
        dataManager.updateAndSave(todo: todo)
        XCTAssertEqual(dataManager.todos.count, 1)
        
        todo.title = "New title"
        dataManager.updateAndSave(todo: todo)
    }

}
