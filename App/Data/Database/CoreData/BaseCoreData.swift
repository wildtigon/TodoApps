//
//  BaseCoreData.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import CoreData

protocol BaseCoreData {
    associatedtype Element
    var context: NSManagedObjectContext { get }
    func add(_ config: ((Element) -> Void)?) -> Element?
    func getAll() throws -> [Element]
    func dropMe()
}

extension BaseCoreData {
    var context: NSManagedObjectContext {
        CoreDataStack.shared.managedContext
    }
    
    var TABLE: String { .init(describing: Element.self) }
    
    @discardableResult
    func add(_ config: ((Element) -> Void)?) -> Element? {
        guard let entity = NSEntityDescription.entity(forEntityName: TABLE, in: context),
              let element = NSManagedObject(entity: entity, insertInto: context) as? Element else {
            return nil
        }
        
        config?(element)
        
        do {
            try context.save()
            return element
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func getAll() throws -> [Element] {
        let request = NSFetchRequest<NSManagedObject>(entityName: TABLE)
        return try context.fetch(request).compactMap({$0 as? Element})
    }
    
    func dropMe() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TABLE)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                try context.save()
            }
        } catch let error {
            print("Detele all data in \(TABLE) error :", error)
        }
    }
}
