//
//  TVShowDetails.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowDetails: View {

    var tvShow: TVShow
    var seasons: [TVShowSeason]
    var credits: Credits
    var recommendations: [TVShow]

    private var topCast: [CastMember] {
        Array(credits.cast.prefix(10))
    }

    var body: some View {
        #if os(iOS)
        content
            .listStyle(InsetGroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            Section(header: TVShowDetailsHeader(tvShow: tvShow)) {
                EmptyView()
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, -20)

            if let overview = tvShow.overview {
                #if !os(watchOS)
                Section {
                    ShowPlotRow(title: tvShow.name, plot: overview)
                }
                #else
                ShowPlotRow(title: tvShow.name, plot: overview)
                #endif
            }

            if let seasons = tvShow.seasons, !seasons.isEmpty {
                #if !os(watchOS)
                Section(header: Text("Seasons").listSectionHeaderStyle()) {
                    TVShowSeasonsCarousel(tvShowID: tvShow.id, seasons: seasons, displaySize: .medium)
                        .listRowInsets(EdgeInsets())
                }
                #else
                NavigationLink(destination: TVShowSeasonsView(tvShowID: tvShow.id)) {
                    HStack {
                            Spacer()
                            Text("Seasons")
                            Spacer()
                        }
                }
                #endif
            }

            if !topCast.isEmpty {
                #if !os(watchOS)
                Section(header: castAndCrewSectionHeader) {
                    CastCarousel(cast: topCast, displaySize: .large)
                        .listRowInsets(EdgeInsets())
                }
                #else
                NavigationLink(destination: TVShowCreditsView(tvShowID: tvShow.id)) {
                    HStack {
                        Spacer()
                        Text("Cast & Crew")
                        Spacer()
                    }
                }
                #endif
            }

            if !recommendations.isEmpty {
                #if !os(watchOS)
                Section(header: Text("Recommendations").listSectionHeaderStyle()) {
                    TVShowsCarousel(tvShows: recommendations, displaySize: .medium)
                        .listRowInsets(EdgeInsets())
                }
                #else
                NavigationLink(destination: RecommendedTVShowsView(tvShowID: tvShow.id)) {
                    HStack {
                        Spacer()
                        Text("Recommendations")
                        Spacer()
                    }
                }
                #endif
            }
        }
    }

    private var castAndCrewSectionHeader: some View {
        HStack {
            Text("Top Cast")
                .listSectionHeaderStyle()
            Spacer()
            NavigationLink(destination: TVShowCreditsView(tvShowID: tvShow.id)) {
                Text("See all")
                    .font(.body)
                    .foregroundColor(.accentColor)
                    .textCase(.none)
            }
        }
    }

}

//struct TVShowDetails_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TVShowDetails()
//    }
//
//}
