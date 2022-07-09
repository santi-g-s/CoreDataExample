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
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            dataManager.delete(todo: dataManager.todos[index])
        }
    }
    
}
