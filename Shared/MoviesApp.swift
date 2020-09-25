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

    @StateObject private var movieStore = MovieStore()
    @StateObject private var tvShowStore = TVShowStore()
    @StateObject private var personStore = PersonStore()
    @StateObject private var networkMonitor = NetworkMonitor()
    @StateObject private var cloudKitAvailability = CloudKitAvailability()

    init() {
        TMDbAPI.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
    }

    var body: some Scene {
        #if os(watchOS)
        WatchAppScene(
            movieStore: movieStore,
            tvShowStore: tvShowStore,
            personStore: personStore,
            cloudKitAvailability: cloudKitAvailability
        )
        #elseif os(macOS)
        MacAppScene(
            movieStore: movieStore,
            tvShowStore: tvShowStore,
            personStore: personStore,
            cloudKitAvailability: cloudKitAvailability
        )
        #else
        MainAppScene(
            movieStore: movieStore,
            tvShowStore: tvShowStore,
            personStore: personStore,
            networkMonitor: networkMonitor,
            cloudKitAvailability: cloudKitAvailability
        )
        #endif
    }

}
