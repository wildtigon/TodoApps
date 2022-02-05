//
//  UITableViewCell+Ext.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
