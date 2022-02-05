//
//  BuyItemDTO.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation
import Domain

public struct BuyItemDTO: Codable {
    let id: Int
    let name: String
    let price: Double
    let quantity: Int
    let type: Int
    
    var asDomain: ProductItem {
        ProductItem(id: id, name: name, price: price, quantity: quantity, type: type)
    }
}
