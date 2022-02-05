//
//  DummyCallListRepository.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Domain

public class DummyCallListRepository: CallListRepository {
    public init() {}
    
    public func fetchContactList(completion: ((Result<[Contact], Error>) -> Void)) {
        let list = [
            ContactDTO(id: 1, name: "Tigon", number: "12345123"),
            ContactDTO(id: 2, name: "Dat Nguyen", number: "123451523"),
            ContactDTO(id: 3, name: "Beomaps", number: "123451323")
        ].map(\.asDomain)
        completion(.success(list))
    }
}
