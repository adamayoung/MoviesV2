//
//  MoviesApp.swift
//  Shared
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb

let store = AppStore(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment()
)

@main
struct MoviesApp: App {

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif

    init() {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
        store.send(.movies(.fetchFavourites))
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
