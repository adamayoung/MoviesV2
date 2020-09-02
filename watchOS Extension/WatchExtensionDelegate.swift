//
//  WatchExtensionDelegate.swift
//  Movies (watchOS Extension)
//
//  Created by Adam Young on 01/09/2020.
//

import WatchKit

class WatchExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        WKExtension.shared().registerForRemoteNotifications()
    }

    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) { }

    func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) { }

    func didReceiveRemoteNotification(_ userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (WKBackgroundFetchResult) -> Void) {
        store.send(.handleRemoteNotification(userInfo: userInfo))
        completionHandler(.newData)
    }

}
