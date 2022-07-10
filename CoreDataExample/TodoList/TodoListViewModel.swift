//
//  TodoListViewModel.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI
import Combine

@MainActor
final class TodoListViewModel: ObservableObject {
    
    @Published var showEditor = false
    @Published var isFiltered = false
    @Published var isSorted = false
    
    @Published private var dataManager: DataManager
    
    var anyCancellable: AnyCancellable? = nil
    
    init(dataManager: DataManager = DataManager.shared) {
        self.dataManager = dataManager
        anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    var todos: [Todo] {
        dataManager.todos
    }
    
    func getProject(with id: UUID?) -> Project? {
        guard let id = id else { return nil }
        return dataManager.getProject(with: id)
    }
    
    func toggleIsComplete(todo: Todo) {
        var newTodo = todo
        newTodo.isComplete.toggle()
        dataManager.updateAndSave(todo: newTodo)
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            dataManager.delete(todo: dataManager.todos[index])
        }
    }
    
    func toggleFilter() {
        isFiltered.toggle()
        if isFiltered {
            dataManager.fetchTodos(predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: false)))
        } else {
            dataManager.fetchTodos(predicate: NSPredicate(format: "TRUEPREDICATE"))
        }
    }
    
    func toggleSort() {
        isSorted.toggle()
        if isSorted {
            dataManager.fetchTodos(sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)])
        } else {
            dataManager.fetchTodos(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
        }
    }
    
    func fetchTodos() {
        dataManager.fetchTodos()
    }
    
    
}
