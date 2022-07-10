//
//  Project.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 10/07/2022.
//

import SwiftUI

struct Project: Identifiable, Equatable, Hashable {
    var id: UUID
    var title: String
    var todoIDs = [UUID]()
    
    init(title: String = "") {
        self.id = UUID()
        self.title = title
    }
    
    static func ==(lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}
