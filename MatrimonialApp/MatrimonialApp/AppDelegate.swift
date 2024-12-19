//
//  AppDelegate.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkMonitor.shared.startMonitoring()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        NetworkMonitor.shared.stopMonitoring()
    }
}
