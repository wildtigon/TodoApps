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
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
