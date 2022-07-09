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
                .onTapGesture {
                    viewModel.toggleIsComplete(todo: todo)
                }
            }
            .onDelete { indexSet in
                viewModel.delete(at: indexSet)
            }
        }
        .navigationTitle("Todos")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFilter()
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle" + (viewModel.isFiltered ?  ".fill" : ""))
                }
                Button {
                    viewModel.toggleSort()
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down.circle" + (viewModel.isSorted ?  ".fill" : ""))
                }
            }
        }
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
        NavigationView {
            TodoListView(viewModel: TodoListViewModel(dataManager: DataManager.preview))
        }
    }
}
