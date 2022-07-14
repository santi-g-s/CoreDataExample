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
    @Published var selectedProjectToEdit: Project? = nil
    
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
        dataManager.projectsArray
    }
    
    var searchFilteredProjects: [Project] {
        if !projectSearchText.isEmpty {
            return projects.filter({$0.title.localizedLowercase.contains(projectSearchText.localizedLowercase)})
        } else {
            return projects
        }
    }
    
    func toggleProject(project: Project) {
        if editingTodo.projectID == project.id {
            editingTodo.projectID = nil
        } else {
            editingTodo.projectID = project.id
        }
    }
    
    func saveTodo() {
        dataManager.updateAndSave(todo: editingTodo)
    }
    
    func addNewProject() {
        projectSearchText = String(projectSearchText.trailingSpacesTrimmed)
        if !projects.contains(where: {$0.title.localizedLowercase == projectSearchText.localizedLowercase}) {
            var project = Project()
            project.title = projectSearchText
            dataManager.updateAndSave(project: project)
            projectSearchText = ""
        }
    }
}

extension StringProtocol {

    @inline(__always)
    var trailingSpacesTrimmed: Self.SubSequence {
        var view = self[...]

        while view.last?.isWhitespace == true {
            view = view.dropLast()
        }

        return view
    }
}
