//
//  UIViewController+NVActivityIdicatorView.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit

extension UIViewController {
    func showIndicator(in parentView: UIView? = nil,
                       loadingMessage: String = "",
                       allowsUserInteraction: Bool = false) {
        DispatchQueue.main.async {
            LoadingViewHelper.show(in: parentView ?? UIWindow.key ?? self.view,
                                   loadingMessage: loadingMessage,
                                   allowsUserInteraction: allowsUserInteraction)
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            LoadingViewHelper.hide()
        }
    }
}
