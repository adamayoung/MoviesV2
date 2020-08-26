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

    @Environment(\.scenePhase) var scenePhase

    @StateObject var store = AppStore(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment()
    )

    init() {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
        #if os(iOS)
        WidgetCenter.shared.reloadAllTimelines()
        #endif
    }

    @SceneBuilder var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }

        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
        #endif
    }

}
