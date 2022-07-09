//
//  TodoListView.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

struct TodoListView: View {
    
    @StateObject var viewModel = TodoListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.todos) { todo in
                HStack {
                    Image(systemName: todo.isComplete ? "checkmark.circle.fill" : "checkmark.circle")
                    Text(todo.title)
                }
            }
            .onDelete { indexSet in
                viewModel.delete(at: indexSet)
            }
        }
        .navigationTitle("Todos")
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.showEditor = true
            } label: {
                Label("New Todo", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $viewModel.showEditor) {
            TodoEditorView()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(viewModel: TodoListViewModel(dataManager: DataManager.preview))
    }
}
