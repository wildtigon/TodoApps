//
//  RemoteCallListRepositoryImpl.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Domain
import Moya

public class RemoteCallListRepositoryImpl: RemoteCallListRepository {
    
    public init() {}
    
    public func fetchContactList(completion: @escaping((Result<[Contact], Error>) -> Void)) {
        APIClient.shared.provider.request(MultiTarget(DemoAPIs.calllist)) { result in
            switch result {
            case .success(let response):
                if let contacts = try? JSONDecoder().decode([ContactDTO].self, from: response.data) {
                    completion(.success(contacts.map(\.asDomain)))
                } else {
                    let err = NSError(domain: "Can't parse object", code: 0, userInfo: nil)
                    completion(.failure(err))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
