//
//  ContentView.swift
//  Shared
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct ContentView: View {

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        content
            .onChange(of: scenePhase) { newScenePhase in
                switch newScenePhase {
                case .active:
                    break

                case .inactive:
                    break

                case .background:
                    break

                @unknown default:
                    break
                }
            }
    }

    @ViewBuilder private var content: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            AppTabNavigation()
        } else {
            AppSidebarNavigation()
        }
        #elseif os(watchOS)
        AppWatchNavigation()
        #else
        AppSidebarNavigation()
            .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        #endif
    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }

}
