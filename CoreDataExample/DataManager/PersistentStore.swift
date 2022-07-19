//
//  PersistentStore.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import CoreData

struct PersistentStore {
    
    static let shared = PersistentStore()
    
    static var preview: PersistentStore = {
        let store = PersistentStore(inMemory: true)
        let context = store.container.viewContext
        for i in 0..<10 {
            let newTodo = TodoMO(context: context)
            newTodo.title = "Todo \(i)"
            newTodo.isComplete = false
            newTodo.date = Date()
            newTodo.id = UUID()
        }
        for i in 0..<4 {
            let newProject = ProjectMO(context: context)
            newProject.title = "Project \(i)"
            newProject.id = UUID()
        }
        try? context.save()
        return store
    }()
    
    static var testing = PersistentStore(inMemory: true)

    let container: NSPersistentContainer

    init(inMemory: Bool = false, modelUrl: URL? = nil) {
        if let modelUrl = modelUrl {
            let mom = NSManagedObjectModel(contentsOf: modelUrl)! // TODO: handle !
            container = NSPersistentContainer(name: "CoreDataModel", managedObjectModel: mom)
        } else {
            container = NSPersistentContainer(name: "CoreDataModel")
        }
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    var context: NSManagedObjectContext { container.viewContext }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

