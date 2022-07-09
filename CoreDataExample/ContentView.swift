//
//  ContentView.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TodoListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
