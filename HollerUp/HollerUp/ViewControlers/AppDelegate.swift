//
//  AppDelegate.swift
//  HollerUP
//
//  Created by Vamsi on 06/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        self.pushingToRootViewController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}
extension AppDelegate{
    func pushingToRootViewController(){
        if let tabBarController = window?.rootViewController as? TabBarController {
            tabBarController.selectedIndex = 2
            DispatchQueue.main.async {
                if let unselectedImage = UIImage(named: "HollerUp-Icon-Deactive"), let selectedImage = UIImage(named: "HollerUp-Icon-Active") {
                    tabBarController.addCenterButton(unselectedImage: unselectedImage, selectedImage: selectedImage)
                }
            }
        }
    }
}
