//
//  AppSidebarNavigation.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct AppSidebarNavigation: View {

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            Sidebar()
                .listStyle(SidebarListStyle())
                .frame(minWidth: 100, idealWidth: 150, maxHeight: .infinity)

            List { }

            Text("Select a Movie or TV Show")
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                SearchBar(text: $searchText)
                    .frame(minWidth: 200, idealWidth: 250)
                Spacer()
            }
        }
    }

}

struct AppSidebarNavigation_Previews: PreviewProvider {

    static var previews: some View {
        AppSidebarNavigation()
    }

}
