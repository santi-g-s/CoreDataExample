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
    
    let dataManager = DataManager.shared
    
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
                dataManager.saveData()
            case .background:
                print("background")
                dataManager.saveData()
            default:
                print("unknown")
            }
        }
    }
}
