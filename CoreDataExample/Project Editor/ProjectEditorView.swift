//
//  ProjectEditorView.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 10/07/2022.
//

import SwiftUI

struct ProjectEditorView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ProjectEditorViewModel
    
    init(project: Project?, dataManager: DataManager = DataManager.shared) {
        self.viewModel = ProjectEditorViewModel(project: project, dataManager: dataManager)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $viewModel.editingProject.title)
            }
            
            Section {
                ForEach(viewModel.editingProject.todoIDs, id: \.self) { todoID in
                    if let todo = viewModel.getTodo(with: todoID) {
                        Text(todo.title)
                    }
                }
            } header: {
                Text("Todos in Project")
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                presentationMode.wrappedValue.dismiss()
                withAnimation {
                    viewModel.saveProject()
                }
            } label: {
                Label("Save", systemImage: "checkmark.circle")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
    }
}

struct ProjectEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditorView(project: Project(), dataManager: DataManager.preview)
    }
}
