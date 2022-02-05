//
//  AppDelegate.swift
//  App
//
//  Created by Nguyen Tien Dat on 2/5/22.
//

import UIKit
import CoreData
import Data

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = {
        .init(frame: UIScreen.main.bounds)
    }()
    
    private lazy var analyticsService: AnalyticsService = {
        let service = AnalyticsServiceImpl()
        service.register(providers: [
            LocalAnaytics(),
            FirebaseAnalytics(),
            ZhugeAnalytics()
        ])
        return service
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyInjection.config(with: analyticsService)
        configAPIs()
        initRootView()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack.shared.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.shared.saveContext()
    }
    
    private func configAPIs() {
        guard let url = URL(string: "https://my-json-server.typicode.com/imkhan334/demo-1") else { return }
        APIClient.shared.set(baseURL: url)
    }
    
    private func initRootView() {
        guard let homeVC = container.resolve(HomeViewController.self) else { return }
        let nc = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}
