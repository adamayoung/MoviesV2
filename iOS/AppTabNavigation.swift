//
//  AppTabNavigation.swift
//  iOS
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct AppTabNavigation: View {

    @AppStorage("tabNavigationSelecton") private var selection: Tab = .home
    @EnvironmentObject private var store: AppStore

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
                    .accessibility(label: Text("Home"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tag(Tab.home)

            NavigationView {
                SearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
                    .accessibility(label: Text("Search"))
            }
            .tag(Tab.search)

            NavigationView {
                FavouriteMoviesView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Favourites", systemImage: "heart.circle")
                    .accessibility(label: Text("Favourites"))
            }
            .tag(Tab.favourites)
//
//            NavigationView {
//                WatchListView()
//            }
//            .tabItem {
//                Label("Watch List", systemImage: "eyeglasses")
//                    .accessibility(label: Text("Watch List"))
//            }
//            .tag(Tab.watchList)
//
//            NavigationView {
//                WatchListView()
//            }
//            .tabItem {
//                Label("Settings", systemImage: "gear")
//                    .accessibility(label: Text("Settings"))
//            }
//            .tag(Tab.settings)
        }
        .onOpenURL(perform: openURL)
    }

}

extension AppTabNavigation {

    private func openURL(url: URL) {
        guard
            url.isDeeplink,
            let tab = Tab(deepLink: url)
        else {
            return
        }

        selection = tab
    }

}

extension AppTabNavigation {

    enum Tab: Int {
        case home
        case search
        case favourites
        case watchList
        case settings

        init?(deepLink url: URL) {
            switch url.host {
            case "home":
                self = .home

            case "search":
                self = .search

            default:
                return nil
            }
        }
    }

}

struct AppTabNavigation_Previews: PreviewProvider {

    static var previews: some View {
        AppTabNavigation()
    }

}
