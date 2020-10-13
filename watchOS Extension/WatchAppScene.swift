//
//  WatchAppScene.swift
//  Movies (watchOS Extension)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct WatchAppScene: Scene {

    @ObservedObject var movieStore: MovieStore
    @ObservedObject var tvShowStore: TVShowStore
    @ObservedObject var personStore: PersonStore
    @ObservedObject var cloudKitAvailability: CloudKitAvailability

    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            AppWatchNavigation()
                .environmentObject(movieStore)
                .environmentObject(tvShowStore)
                .environmentObject(personStore)
                .environmentObject(cloudKitAvailability)
        }

        WKNotificationScene(controller: NotificationController.self, category: "Notification")

    }

}
