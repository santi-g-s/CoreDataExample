//
//  TodoListViewModel.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

@MainActor
final class TodoListViewModel: ObservableObject {
    
    @Published var showEditor = false
    
    @ObservedObject var dataManager: DataManager
    
    init(dataManager: DataManager = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            dataManager.delete(todo: dataManager.todos[index])
        }
    }
    
}
