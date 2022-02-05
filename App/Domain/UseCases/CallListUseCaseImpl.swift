//
//  CallListUseCaseImpl.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

public class CallListUseCaseImpl: CallListUseCase {
    
    private let repo: CallListRepository
    public init(with repo: CallListRepository) {
        self.repo = repo
    }
        
    public var fetchContactList: Single<[Contact]> {
        .create { [unowned self] single in
            self.repo.fetchContactList { result in
                switch result {
                case .success(let contacts):
                    single(.success(contacts))
                case .failure(let err):
                    single(.failure(err))
                }
            }
            return Disposables.create()
        }
    }
}
