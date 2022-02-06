//
//  ObservableType+Ext.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { _ in .empty() }
    }
}
