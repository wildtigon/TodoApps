//
//  UIWindow+Ext.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
