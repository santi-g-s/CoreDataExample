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
    @Published var projectSearchText: String = ""
    
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
    
    var projects: [Project] {
        dataManager.projects
    }
    
    func toggleProject(project: Project) {
        if editingTodo.project == project {
            editingTodo.project = nil
        } else {
            editingTodo.project = project
        }
    }
    
    func saveTodo() {
        dataManager.updateAndSave(todo: editingTodo)
    }
    
    func addNewProject() {
        if !projects.contains(where: {$0.title.localizedLowercase == projectSearchText.localizedLowercase}) {
            var project = Project()
            project.title = projectSearchText
            dataManager.updateAndSave(project: project)
            projectSearchText = ""
        }
    }
}
