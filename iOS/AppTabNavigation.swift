//
//  AppTabNavigation.swift
//  iOS
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct AppTabNavigation: View {

    @AppStorage("tabNavigationSelecton") private var selection: Tab = .home
    @State private var sheetItem: SheetItem?
    @EnvironmentObject private var store: AppStore

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Home", systemImage: "house.fill")
                    .accessibility(label: Text("Home"))
            }
            .tag(Tab.home)

            NavigationView {
                SearchView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
                    .accessibility(label: Text("Search"))
            }
            .tag(Tab.search)

            NavigationView {
                FavouritesView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Favourites", systemImage: "heart.fill")
                    .accessibility(label: Text("Favourites"))
            }
            .tag(Tab.favourites)
        }
        .sheet(item: $sheetItem) { item in
            NavigationView {
                switch item {
                case .movieDetails(let movieID):
                    MovieDetailsView(id: movieID)

                case .tvShowDetails(let tvShowID):
                    TVShowDetailsView(id: tvShowID)

                case .personDetails(let personID):
                    PersonDetailsView(id: personID)
                }
            }
            .environmentObject(store)
        }
        .onOpenURL(perform: openURL)
    }

}

extension AppTabNavigation {

    private func openURL(url: URL) {
        guard url.isDeeplink else {
            return
        }

        if let sheetItem = SheetItem(deepLink: url) {
            if self.sheetItem == nil {
                self.sheetItem = sheetItem
                return
            }

            self.sheetItem = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.sheetItem = sheetItem
            }

            return
        }

        if let selection = Tab(deepLink: url) {
            self.sheetItem = nil
            self.selection = selection
            return
        }
    }

}

extension AppTabNavigation {

    private enum Tab: Int {
        case home
        case search
        case favourites
        case watchList
        case settings

        init?(deepLink url: URL) {
            switch url.host {
            case "home":
                self = .home

            case "movies", "tvshows", "people":
                guard !url.pathComponents.isEmpty else {
                    return nil
                }

                self = .home

            case "search":
                self = .search

            case "favourites":
                self = .favourites

            default:
                return nil
            }
        }
    }

    private enum SheetItem: Hashable, Identifiable {

        var id: Int {
            switch self {
            case .movieDetails(let movieID):
                return movieID

            case .tvShowDetails(let tvShowID):
                return tvShowID

            case .personDetails(let personID):
                return personID
            }
        }

        case movieDetails(Movie.ID)
        case tvShowDetails(TVShow.ID)
        case personDetails(Person.ID)

        init?(deepLink url: URL) {
            switch url.host {
            case "movies":
                guard
                    url.pathComponents.count == 2,
                    let idString = url.pathComponents.last,
                    let id = Int(idString)
                else {
                    return nil
                }

                self = .movieDetails(id)

            case "tvshows":
                guard
                    url.pathComponents.count == 2,
                    let idString = url.pathComponents.last,
                    let id = Int(idString)
                else {
                    return nil
                }

                self = .tvShowDetails(id)

            case "people":
                guard
                    url.pathComponents.count == 2,
                    let idString = url.pathComponents.last,
                    let id = Int(idString)
                else {
                    return nil
                }

                self = .personDetails(id)

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
