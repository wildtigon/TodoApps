//
//  SellListRepository.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public protocol LocalProductListRepository {
    func fetchSellListItem(completion: @escaping((Result<[ProductItem], Error>) -> Void))
}
