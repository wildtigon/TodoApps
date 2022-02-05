//
//  BuyListUseCaseImpl.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

public class BuyListUseCaseImpl: BuyListUseCase {
    
    private let repo: BuyListRepository
    public init(with repo: BuyListRepository) {
        self.repo = repo
    }
    
    public var fetchBuyListItem: Single<[ProductItem]> {
        .create { [unowned self] single in
            self.repo.fetchBuyListItem { result in
                switch result {
                case .success(let buyList):
                    single(.success(buyList))
                case .failure(let err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
}
