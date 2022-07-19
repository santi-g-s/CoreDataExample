# CoreDataExample

# Note: Latest attempts to make XCTest work are in the `testing` branch

This project serves to present a 'bare-bones' implementation of Core Data and MVVM in SwiftUI.

The 3 binding principles which I wanted to follow when creating this are:
  1. Views should have absolutely **no idea** of `CoreData` or `NSManagedObjects`
  2. A `DataManager` class should be the one source of truth for all stored data, a singleton of this should be passed into ViewModels
  3. You should be able to UnitTest and use previews freely and independently from the DataManager class
  
> Please feel free to comment on your tips, feedback, questions or anything else related.

### Acknowledgments

* [This fantastic project](https://github.com/delawaremathguy/ShoppingList15) by delawaremathguy
