//
//  CoreDataProductListRepositoryImpl.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation
import Domain
import CoreData

public class CoreDataProductListRepositoryImpl: LocalProductListRepository, BaseCoreData {
    typealias Element = ItemToSell
    
    public init() {
        generateMockData()
    }
    
    public func fetchSellListItem(completion: @escaping ((Result<[ProductItem], Error>) -> Void)) {
        do {
            let result = try getAll().map(\.asDomain)
            completion(.success(result))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func generateMockData() {
        dropMe()
        let mockData =  [
            ProductItemDTO(id: 1, name: "iPhone X", price: 150000, quantity: 1, type: 2),
            ProductItemDTO(id: 2, name: "TV", price: 38000, quantity: 2, type: 2),
            ProductItemDTO(id: 3, name: "Table", price: 12000, quantity: 1, type: 2)
        ]
        
        mockData.forEach { product in
            add {
                $0.setValue(product.id, forKeyPath: #keyPath(ItemToSell.id))
                $0.setValue(product.name, forKeyPath: #keyPath(ItemToSell.name))
                $0.setValue(product.price, forKeyPath: #keyPath(ItemToSell.price))
                $0.setValue(product.quantity, forKeyPath: #keyPath(ItemToSell.quantity))
                $0.setValue(product.type, forKeyPath: #keyPath(ItemToSell.type))
            }
        }
    }
}

extension ItemToSell {
    convenience init(id: Int, name: String, price: Double, quantity: Int, type: Int) {
        self.init()
        self.id = Int32(id)
        self.name = name
        self.price = price
        self.quantity = Int32(quantity)
        self.type = Int32(type)
    }
    
    var asDomain: ProductItem {
        ProductItem(
            id: Int(id), name: name ?? "", price: price, quantity: Int(quantity), type: Int(type)
        )
    }
}
