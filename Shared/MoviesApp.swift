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

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #endif

    #if os(watchOS)
    @WKExtensionDelegateAdaptor(WatchExtensionDelegate.self) private var appDelegate
    #endif

    @StateObject private var movieStore = MovieStore()
    @StateObject private var tvShowStore = TVShowStore()
    @StateObject private var personStore = PersonStore()

    init() {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
    }

    var body: some Scene {
        #if os(watchOS)
        WatchAppScene(movieStore: movieStore, tvShowStore: tvShowStore, personStore: personStore)
        #elseif os(macOS)
        MacAppScene(movieStore: movieStore, tvShowStore: tvShowStore, personStore: personStore)
        #else
        MainAppScene(movieStore: movieStore, tvShowStore: tvShowStore, personStore: personStore)
        #endif
    }

}
