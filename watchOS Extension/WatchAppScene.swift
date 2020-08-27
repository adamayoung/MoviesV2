//
//  WatchAppScene.swift
//  Movies (watchOS Extension)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct WatchAppScene: Scene {

    @ObservedObject var store: AppStore

    var body: some Scene {
        WindowGroup {
            AppWatchNavigation()
                .environmentObject(store)
        }

        WKNotificationScene(controller: NotificationController.self, category: "Notification")
    }

}
