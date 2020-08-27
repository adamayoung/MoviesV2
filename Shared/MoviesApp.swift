//
//  MoviesApp.swift
//  Shared
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb

@main
struct MoviesApp: App {

    @StateObject var store = AppStore(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment()
    )

    init() {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
    }

    var body: some Scene {
        #if os(watchOS)
        WatchAppScene(store: store)
        #elseif os(macOS)
        MacAppScene(store: store)
        #else
        MainAppScene(store: store)
        #endif
    }

}
