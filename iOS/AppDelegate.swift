//
//  AppDelegate.swift
//  Movies
//
//  Created by Adam Young on 01/09/2020.
//

import CloudKit
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()

        return true
    }

}
