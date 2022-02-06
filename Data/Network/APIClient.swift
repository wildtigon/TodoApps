//
//  APIClient.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Moya

public class APIClient {
    public static let shared = APIClient()
    
    let provider = MoyaProvider<MultiTarget>()
    
    var baseURL: URL?
    
    private init() {}
    
    public func set(baseURL: URL) {
        self.baseURL = baseURL
    }
}
