//
//  Contact.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public struct Contact {
    public let id: Int
    public let name: String
    public let number: String
    
    public init(id: Int, name: String, number: String) {
        self.id = id
        self.name = name
        self.number = number
    }
}
