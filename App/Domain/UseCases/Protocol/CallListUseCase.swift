//
//  CallListUseCase.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift

public protocol CallListUseCase {
    var fetchContactList: Single<[Contact]> { get }
}
