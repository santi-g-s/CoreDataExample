//
//  DataManager.swift
//  CoreDataExample
//
//  Created by Santiago Garcia Santos on 09/07/2022.
//

import Foundation
import CoreData

enum DataManagerType {
    case normal, preview, testing
}

class DataManager: NSObject, ObservableObject {
    
    static let shared = DataManager(type: .normal)
    static let preview = DataManager(type: .preview)
    
    @Published var todos = [Todo]()
    
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let todosFRC: NSFetchedResultsController<TodoMO>
    
    private init(type: DataManagerType) {
        switch type {
        case .normal:
            let persistentStore = PersistentStore()
            self.managedObjectContext = persistentStore.context
        case .preview:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
            for i in 0..<10 {
                let newTodo = TodoMO(context: managedObjectContext)
                newTodo.title = "Todo \(i)"
                newTodo.isComplete = false
                newTodo.date = Date()
                newTodo.id = UUID()
            }
            try? self.managedObjectContext.save()
        case .testing:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
        }
        
        let todoFR: NSFetchRequest<TodoMO> = TodoMO.fetchRequest()
        todoFR.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        todosFRC = NSFetchedResultsController(fetchRequest: todoFR,
                                              managedObjectContext: managedObjectContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
        super.init()
        
        // Initial fetch to populate todos array
        todosFRC.delegate = self
        try? todosFRC.performFetch()
        if let newTodos = todosFRC.fetchedObjects {
            self.todos = newTodos.map({todo(from: $0)})
        }
    }
    
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

extension DataManager: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //print("Did Change Content")
        if let newTodos = controller.fetchedObjects as? [TodoMO] {
            print(newTodos)
            self.todos = newTodos.map({todo(from: $0)})
            print(todos)
        }
    }
    
    private func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try managedObjectContext.fetch(request) as? [T]
            return .success(result?.first)
        } catch {
            return .failure(error)
        }
    }

}

//MARK: - Todo Methods
extension Todo {
    fileprivate init(todoMO: TodoMO) {
        //self.init(title: todoMO.title ?? "", date: todoMO.date ?? Date(), isComplete: todoMO.isComplete)
        self.id = todoMO.id ?? UUID()
        self.title = todoMO.title ?? ""
        self.date = todoMO.date ?? Date()
        self.isComplete = todoMO.isComplete
    }
}

extension DataManager {
    
    func updateAndSave(todo: Todo) {
        let predicate = NSPredicate(format: "id = %@", todo.id as CVarArg)
        let result = fetchFirst(TodoMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let todoMo = managedObject {
                update(todoMO: todoMo, from: todo)
            } else {
                todoMO(from: todo)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        
        saveData()
    }
    
    func delete(todo: Todo) {
        let predicate = NSPredicate(format: "id = %@", todo.id as CVarArg)
        let result = fetchFirst(TodoMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let todoMo = managedObject {
                managedObjectContext.delete(todoMo)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        saveData()
    }
    
    private func todo(from todoMO: TodoMO) -> Todo {
        Todo(todoMO: todoMO)
    }
    
    private func todoMO(from todo: Todo) {
        let todoMO = TodoMO(context: managedObjectContext)
        todoMO.id = todo.id
        todoMO.title = todo.title
        todoMO.date = todo.date
        todoMO.isComplete = todo.isComplete
    }
    
    private func update(todoMO: TodoMO, from todo: Todo) {
        todoMO.title = todo.title
        todoMO.date = todo.date
        todoMO.isComplete = todo.isComplete
    }
    
}
