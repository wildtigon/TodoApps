//
//  SellListUseCaseImpl.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

public class SellListUseCaseImpl: SellListUseCase {
    
    private let repo: LocalProductListRepository
    public init(with repo: LocalProductListRepository) {
        self.repo = repo
    }
    
    public var fetchSellListItem: Single<[ProductItem]> {
        .create { [unowned self] single in
            self.repo.fetchSellListItem { result in
                switch result {
                case .success(let sellList):
                    single(.success(sellList))
                case .failure(let err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
}
