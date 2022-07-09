//
//  TodoEditorView.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

struct TodoEditorView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var dataManager = DataManager.shared
    
    @State var todo = Todo()
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $todo.title)
                DatePicker("Date", selection: $todo.date)
                Toggle("Complete", isOn: $todo.isComplete)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                presentationMode.wrappedValue.dismiss()
                dataManager.updateAndSave(todo: todo)
            } label: {
                Label("Save", systemImage: "checkmark.circle")
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Todo Editor")
    }
}

struct TodoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditorView()
    }
}
