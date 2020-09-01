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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //registerForPushNotifications(application)
        application.registerForRemoteNotifications()

        return true
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

//
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        store.send(.handleRemoteNotification(userInfo: userInfo))
        completionHandler(.newData)
    }

}

extension AppDelegate {

    private func registerForPushNotifications(_ application: UIApplication) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                guard granted else {
                    return
                }

                #if !targetEnvironment(simulator)
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
                #endif
            }
    }

}
