//
//  TodoEditorViewModel.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI
import Combine

@MainActor
final class TodoEditorViewModel: ObservableObject {
    
    @Published var editingTodo: Todo
    
    @Published private var dataManager: DataManager
    
    var anyCancellable: AnyCancellable? = nil
    
    init(todo: Todo?, dataManager: DataManager = DataManager.shared) {
        if let todo = todo {
            self.editingTodo = todo
        } else {
            self.editingTodo = Todo()
        }
        self.dataManager = dataManager
        anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func save() {
        dataManager.updateAndSave(todo: editingTodo)
    }
}
