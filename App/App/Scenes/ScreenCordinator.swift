//
//  ScreenCordinator.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import Domain

enum ScreenCordinator {
    static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let keyWindow = UIWindow.key
        let vc = viewController ?? keyWindow?.rootViewController
        if let navigationController = vc as? UINavigationController {
            return topViewController(navigationController.topViewController)
        } else if let tabBarController = vc as? UITabBarController {
            return tabBarController.presentedViewController != nil ? topViewController(tabBarController.presentedViewController) : topViewController(tabBarController.selectedViewController)
            
        } else if let presentedViewController = vc?.presentedViewController {
            return topViewController(presentedViewController)
        }
        return vc
    }
    
    static var rootNavigation: UINavigationController? {
        UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    static func showCallListScreen() {
        guard let vc = container.resolve(CallListViewController.self) else { return }
        rootNavigation?.pushViewController(vc, animated: true)
    }
    
    static func showBuyListScreen() {
        guard let vc = container.resolve(BuyListViewController.self) else { return }
        rootNavigation?.pushViewController(vc, animated: true)
    }
    
    static func showSellListScreen() {
        guard let vc = container.resolve(SellListViewController.self) else { return }
        rootNavigation?.pushViewController(vc, animated: true)
    }
}
