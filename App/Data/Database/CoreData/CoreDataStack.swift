//
//  CoreDataStack.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import CoreData

public class CoreDataStack {
    public static let shared = CoreDataStack()
    private let modelName = "Data"
    
    lazy var managedContext: NSManagedObjectContext = {
        storeContainer.viewContext
    }()
    
    private init() {}
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName, bundle: Bundle(for: Self.self))
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    @discardableResult
    public func saveContext() -> Bool {
        guard managedContext.hasChanges else { return false }
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return false
        }
    }
}
