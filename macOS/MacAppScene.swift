//
//  MacAppScene.swift
//  Movies (macOS)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct MacAppScene: Scene {

    @ObservedObject var movieStore: MovieStore
    @ObservedObject var tvShowStore: TVShowStore
    @ObservedObject var personStore: PersonStore

    var body: some Scene {
        WindowGroup {
            AppSidebarNavigation()
                .environmentObject(movieStore)
                .environmentObject(tvShowStore)
                .environmentObject(personStore)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        SearchBar(text: .constant(""))
                            .frame(minWidth: 200, idealWidth: 250)
                    }
                }
                .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        }
    }

}
