//
//  Optional+Ext.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import Foundation

public extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        default:
            return ""
        }
    }
}
