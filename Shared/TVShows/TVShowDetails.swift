//
//  TVShowDetails.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowDetails: View {

    #if os(watchOS)
    private let listStyle = DefaultListStyle()
    #else
    private let listStyle = InsetGroupedListStyle()
    #endif

    private var topCast: [CastMember] {
        Array(credits.cast.prefix(10))
    }

    var tvShow: TVShow
    var credits: Credits

    var body: some View {
        List {
            Section(header: header) {
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

            if !credits.isEmpty {
                #if !os(watchOS)
                Section(header: Text("Cast & Crew")) {
                    if !topCast.isEmpty {
                        CastCarousel(cast: topCast, displaySize: .medium)
                            .listRowInsets(EdgeInsets())
                    }

                    NavigationLink(destination: CreditsView(tvShowID: tvShow.id)) {
                        Text("All Cast & Crew")
                    }
                }
                #else
                NavigationLink(destination: CreditsView(tvShowID: tvShow.id)) {
                    HStack {
                        Spacer()
                        Text("Cast & Crew")
                        Spacer()
                    }
                }
                #endif
            }
        }
        .listStyle(listStyle)
    }

    private var header: some View {
        ShowDetailsHeader(tvShow: tvShow)
            .id("tvShow-overview-header-\(tvShow.id)")
    }

}

//struct TVShowDetails_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TVShowDetails()
//    }
//
//}
