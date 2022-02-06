//
//  DemoAPIs.swift
//  Data
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Moya

enum DemoAPIs {
    case calllist
    case buylist
}

extension DemoAPIs: TargetType {
    var method: Moya.Method { .get }
    var task: Task { .requestPlain }
    var headers: [String : String]? { nil }
    
    var baseURL: URL {
        guard let baseURL = APIClient.shared.baseURL else {
            fatalError("Invalid server URL")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .calllist: return "call"
        case .buylist: return "buy"
        }
    }
}
