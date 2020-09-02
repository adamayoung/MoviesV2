//
//  WatchAppScene.swift
//  Movies (watchOS Extension)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct WatchAppScene: Scene {

    @ObservedObject var store: AppStore

    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            AppWatchNavigation()
                .accentColor(Color(UIColor(named: "AccentColor")!))
                .environmentObject(store)
                .onChange(of: scenePhase) { phase in
                    switch phase {
                    case .active:
                        store.send(.movies(.fetchFavourites))

                    default:
                        break
                    }
                }
        }

        WKNotificationScene(controller: NotificationController.self, category: "Notification")
    }

}
