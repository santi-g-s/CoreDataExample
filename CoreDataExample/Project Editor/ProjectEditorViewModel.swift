//
//  ProjectEditorViewModel.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 10/07/2022.
//

import SwiftUI
import Combine

@MainActor
final class ProjectEditorViewModel: ObservableObject {
    
    @Published var editingProject: Project
    
    @Published private var dataManager: DataManager
    
    var anyCancellable: AnyCancellable? = nil
    
    init(project: Project?, dataManager: DataManager = DataManager.shared) {
        if let project = project {
            self.editingProject = project
        } else {
            self.editingProject = Project()
        }
        self.dataManager = dataManager
        anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func getTodo(with id: UUID?) -> Todo? {
        guard let id = id else { return nil }
        return dataManager.getTodo(with: id)
    }
    
    func saveProject() {
        dataManager.updateAndSave(project: editingProject)
    }
}
