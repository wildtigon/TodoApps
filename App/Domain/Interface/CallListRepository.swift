//
//  CallListRepository.swift
//  Domain
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public protocol CallListRepository {
    func fetchContactList(completion: @escaping((Result<[Contact], Error>) -> Void))
}
