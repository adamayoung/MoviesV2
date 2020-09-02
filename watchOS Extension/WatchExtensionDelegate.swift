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

    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) {
        let cancelAction = WKAlertAction(title: "Cancel", style: .cancel) { }
        WKExtension.shared().rootInterfaceController?.presentAlert(withTitle: "Registered", message: "Registered for notifications", preferredStyle: .alert, actions: [cancelAction])
    }

    func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        let cancelAction = WKAlertAction(title: "Cancel", style: .cancel) { }
        WKExtension.shared().rootInterfaceController?.presentAlert(withTitle: "Failed Registering", message: error.localizedDescription, preferredStyle: .alert, actions: [cancelAction])
    }

    func didReceiveRemoteNotification(_ userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (WKBackgroundFetchResult) -> Void) {
        let cancelAction = WKAlertAction(title: "Cancel", style: .cancel) { }
        WKExtension.shared().rootInterfaceController?.presentAlert(withTitle: "Received", message: "Received notification", preferredStyle: .alert, actions: [cancelAction])
        store.send(.handleRemoteNotification(userInfo: userInfo))
        completionHandler(.newData)
    }

}
