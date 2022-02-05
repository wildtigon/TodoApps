//
//  NetworkBuyListRepository.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Domain
import Moya

public class NetworkBuyListRepository: BuyListRepository {
    public init(){}
    public func fetchBuyListItem(completion: @escaping ((Result<[ProductItem], Error>) -> Void)) {
        APIClient.shared.provider.request(MultiTarget(DemoAPIs.buylist)) { result in
            switch result {
            case .success(let response):
                if let contacts = try? JSONDecoder().decode([BuyItemDTO].self, from: response.data) {
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
