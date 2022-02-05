//
//  BuyListRepository.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public protocol BuyListRepository {
    func fetchBuyListItem(completion: @escaping((Result<[ProductItem], Error>) -> Void))
}
