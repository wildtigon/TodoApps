//
//  ProductItem.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public struct ProductItem {
    public let id: Int
    public let name: String
    public let price: Double
    public let quantity: Int
    public let type: Int
    
    public init(id: Int, name: String, price: Double, quantity: Int, type: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
    }
}
