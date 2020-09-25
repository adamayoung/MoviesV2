//
//  MainAppScene.swift
//  Movies (iOS)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI
import WidgetKit

struct MainAppScene: Scene {

    @ObservedObject var movieStore: MovieStore
    @ObservedObject var tvShowStore: TVShowStore
    @ObservedObject var personStore: PersonStore
    @ObservedObject var networkMonitor: NetworkMonitor
    @ObservedObject var cloudKitAvailability: CloudKitAvailability

    @Environment(\.scenePhase) private var scenePhase

    init(movieStore: MovieStore, tvShowStore: TVShowStore, personStore: PersonStore, networkMonitor: NetworkMonitor, cloudKitAvailability: CloudKitAvailability) {
        self.movieStore = movieStore
        self.tvShowStore = tvShowStore
        self.personStore = personStore
        self.networkMonitor = networkMonitor
        self.cloudKitAvailability = cloudKitAvailability
        WidgetCenter.shared.reloadAllTimelines()
    }

    var body: some Scene {
        WindowGroup {
            AppTabNavigation()
                .environmentObject(movieStore)
                .environmentObject(tvShowStore)
                .environmentObject(personStore)
                .environmentObject(networkMonitor)
                .environmentObject(cloudKitAvailability)
        }
    }

}
