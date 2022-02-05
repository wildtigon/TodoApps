//
//  NSPersistentContainer+Ext.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/6/22.
//

import CoreData

extension NSPersistentContainer {
    public convenience init(name: String, bundle: Bundle) {
        guard let modelURL = bundle.url(forResource: name, withExtension: "momd"),
            let mom = NSManagedObjectModel(contentsOf: modelURL)
            else {
                fatalError("Unable to located Core Data model")
        }
        self.init(name: name, managedObjectModel: mom)
    }
}
