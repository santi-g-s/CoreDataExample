//
//  CoreDataExampleApp.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

@main
struct CoreDataExampleApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("Active")
            case .inactive:
                print("Inactive")
                DataManager.shared.saveData()
            case .background:
                print("background")
                DataManager.shared.saveData()
            default:
                print("unknown")
            }
        }
    }
}
