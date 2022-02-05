//
//  LoadingViewHelper.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import NVActivityIndicatorView

final class LoadingViewHelper {
    
    private static var loadingView = LoadingView()
    
    static var isLoading: Bool {
        loadingView.isLoading
    }
    
    static func show(in parentView: UIView,
                     loadingMessage: String? = nil,
                     allowsUserInteraction: Bool = false) {
        guard !isLoading else { return }
        loadingView.show(in: parentView,
                         loadingMessage: loadingMessage,
                         allowsUserInteraction: allowsUserInteraction)
    }
    
    static func hide() {
        loadingView.hide()
    }
    
    static func set(config: LoadingView.Config) {
        loadingView.set(config: config)
    }
}
