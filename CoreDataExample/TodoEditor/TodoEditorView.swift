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
    
    init(todo: Todo?) {
        self.viewModel = TodoEditorViewModel(todo: todo)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $viewModel.editingTodo.title)
                DatePicker("Date", selection: $viewModel.editingTodo.date)
                Toggle("Complete", isOn: $viewModel.editingTodo.isComplete)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                presentationMode.wrappedValue.dismiss()
                withAnimation {
                    viewModel.save()
                }
            } label: {
                Label("Save", systemImage: "checkmark.circle")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .navigationTitle("Edit Todo")
    }
}

struct TodoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditorView(todo: Todo())
    }
}
