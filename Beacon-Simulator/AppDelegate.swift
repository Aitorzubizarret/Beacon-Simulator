//
//  AppDelegate.swift
//  Beacon-Simulator
//
//  Created by Aitor Zubizarreta on 27/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Main View Controller.
        let mainVC: UIViewController = MainViewController(nibName: nil, bundle: nil)
        
        // Navigation Controller for iOS 12 and lower.
        let navigationController: UINavigationController = UINavigationController()
        navigationController.viewControllers = [mainVC]
        
        // Creates the window.
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available (iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available (iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

