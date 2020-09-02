//
//  MacAppScene.swift
//  Movies (macOS)
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct MacAppScene: Scene {

    @ObservedObject var store: AppStore

    var body: some Scene {
        WindowGroup {
            AppSidebarNavigation()
                .environmentObject(store)
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
