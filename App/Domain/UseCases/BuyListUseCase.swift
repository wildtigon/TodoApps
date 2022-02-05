//
//  BuyListUseCase.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

public protocol BuyListUseCase {
    var fetchBuyListItem: Single<[ProductItem]> { get }
}
