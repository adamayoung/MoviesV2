//
//  MainAppScene.swift
//  Movies (iOS)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI
import WidgetKit

struct MainAppScene: Scene {

    @ObservedObject var store: AppStore

    @Environment(\.scenePhase) private var scenePhase

    init(store: AppStore) {
        self.store = store
        WidgetCenter.shared.reloadAllTimelines()
    }

    var body: some Scene {
        WindowGroup {
            AppTabNavigation()
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
    }

}
