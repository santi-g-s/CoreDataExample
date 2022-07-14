//
//  TodoEditorView.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

struct TodoEditorView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: TodoEditorViewModel
    
    init(todo: Todo?, dataManager: DataManager = DataManager.shared) {
        self.viewModel = TodoEditorViewModel(todo: todo, dataManager: dataManager)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $viewModel.editingTodo.title)
                DatePicker("Date", selection: $viewModel.editingTodo.date)
                Toggle("Complete", isOn: $viewModel.editingTodo.isComplete)
            }
            Section {
                TextField("Add a project", text: $viewModel.projectSearchText) {
                    if viewModel.searchFilteredProjects.isEmpty {
                        viewModel.addNewProject()
                    }
                }
                if viewModel.searchFilteredProjects.isEmpty {
                    Button {
                        viewModel.addNewProject()
                    } label: {
                        Label("Add Project", systemImage: "plus.circle")
                    }
                } else {
                    ForEach(viewModel.searchFilteredProjects) { project in
                        Button {
                            viewModel.selectedProjectToEdit = project
                        } label: {
                            HStack {
                                Button {
                                    viewModel.toggleProject(project: project)
                                } label: {
                                    Image(systemName: "circle" + (viewModel.editingTodo.projectID == project.id ? ".fill" : ""))
                                }
                                Text(project.title)
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                presentationMode.wrappedValue.dismiss()
                withAnimation {
                    viewModel.saveTodo()
                }
            } label: {
                Label("Save", systemImage: "checkmark.circle")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .navigationTitle("Edit Todo")
        .sheet(item: $viewModel.selectedProjectToEdit) { project in
            ProjectEditorView(project: project)
        }
    }
}

struct TodoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditorView(todo: Todo(), dataManager: DataManager.preview)
    }
}
