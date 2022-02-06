//
//  SellListUseCase.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

public protocol SellListUseCase {
    var fetchSellListItem: Single<[ProductItem]> { get }
}
