//
//  MoviesApp.swift
//  Shared
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb
#if os(iOS)
import WidgetKit
#endif

@main
struct MoviesApp: App {

    init() {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
        #if os(iOS)
        WidgetCenter.shared.reloadAllTimelines()
        #endif
    }

    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }

        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
        #endif
    }
}
