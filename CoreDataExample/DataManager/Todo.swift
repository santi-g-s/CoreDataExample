//
//  Todo.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import SwiftUI

/**
 This is the view-facing `Todo` struct. Views should have no idea that this struct is
 backed up by a CoreData Managed Object: `TodoMO`. The `DataManager`
 handles keeping this in sync via `NSFetchedResultsControllerDelegate`.
 */
struct Todo: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var isComplete: Bool
    
    init(title: String = "", date: Date = Date(), isComplete: Bool = false) {
        self.id = UUID()
        self.title = title
        self.date = date
        self.isComplete = isComplete
    }
}



