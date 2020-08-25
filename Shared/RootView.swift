//
//  RootView.swift
//  Movies
//
//  Created by Adam Young on 24/07/2020.
//

import SwiftUI

struct RootView: View {

    var body: some View {
        #if os(iOS)
        AppTabNavigation()
        #elseif os(watchOS)
        AppWatchNavigation()
        #else
        AppSidebarNavigation()
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    SearchBar(text: .constant(""))
                        .frame(minWidth: 200, idealWidth: 250)
                }
            }
            .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        #endif
    }
    
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        RootView()
    }
    
}
