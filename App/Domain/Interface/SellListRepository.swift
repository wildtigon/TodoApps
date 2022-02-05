//
//  SellListRepository.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public protocol SellListRepository {
    func fetchSellListItem(completion: @escaping((Result<[ProductItem], Error>) -> Void))
}
