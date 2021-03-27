//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var navigationController: UINavigationController?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        let controller = HomeCollectionViewController(nibName: "HomeCollectionViewController", bundle: nil)
        navigationController = UINavigationController(rootViewController: controller)
        setNavigationBarUI()
        return true
    }

    func setNavigationBarUI() {
        navigationController?.navigationBar.barTintColor = UIColor.orange
        let navigationbarAppearance = UINavigationBar.appearance()
        let barbuttonItemAppearance = UIBarButtonItem.appearance()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationbarAppearance.tintColor = UIColor.white
        barbuttonItemAppearance.tintColor = UIColor.white
        navigationbarAppearance.barTintColor = UIColor.orange
        navigationController?.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

