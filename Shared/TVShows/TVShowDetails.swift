//
//  TVShowDetails.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowDetails: View {

    var tvShow: TVShow
    var credits: Credits
    var recommendations: [TVShowListItem]

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
            Section(header: ShowDetailsHeader(tvShow: tvShow)) {
                EmptyView()
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, -20)

            if let overview = tvShow.overview {
                #if !os(watchOS)
                Section {
                    ShowPlotRow(title: tvShow.name, text: overview)
                }
                #else
                ShowPlotRow(title: tvShow.name, text: overview)
                #endif
            }

            if !topCast.isEmpty {
                #if !os(watchOS)
                Section(header: castAndCrewSectionHeader) {
                    CastCarousel(cast: topCast, displaySize: .medium)
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
                Section(header: Text("Recommendations")) {
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
