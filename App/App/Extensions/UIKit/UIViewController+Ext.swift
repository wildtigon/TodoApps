//
//  UIViewController+Ext.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

extension UIViewController {
    func handle(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true, completion: nil)
    }
}
