//
//  UITableView+Ext.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(nib: T.Type, bundle: Bundle? = nil) {
        let className = nib.reuseIdentifier
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(nib: T.Type, at indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: nib.reuseIdentifier, for: indexPath) as? T
    }
}
