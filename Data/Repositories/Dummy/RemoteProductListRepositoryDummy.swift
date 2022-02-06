//
//  RemoteProductListRepositoryDummy.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation
import Domain

public class RemoteProductListRepositoryDummy: RemoteProductListRepository {
    public init(){}
    public func fetchBuyListItem(completion: @escaping ((Result<[ProductItem], Error>) -> Void)) {
        completion(.success([
            ProductItemDTO(id: 1, name: "Macbook", price: 1000, quantity: 2, type: 1),
            ProductItemDTO(id: 2, name: "iPad", price: 500, quantity: 2, type: 1),
            ProductItemDTO(id: 3, name: "iPhone", price: 900, quantity: 2, type: 1),
        ].map(\.asDomain)))
    }
}
