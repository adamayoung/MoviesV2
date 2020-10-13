//
//  MediaGrid.swift
//  Movies
//
//  Created by Adam Young on 13/10/2020.
//

import SwiftUI

struct MediaGrid: View {

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    @Binding var searchText: String
    var media: [Media] = []
    var mediaItemDidAppear: ((Media) -> Void)?

    private let columnsCompact: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    private let columnsRegular: [GridItem] = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    private var columns: [GridItem] {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return columnsCompact
        } else {
            return columnsRegular
        }
        #else
        return columnsRegular
        #endif
    }

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                #if !os(watchOS)
                Section(header: searchHeader) {
                    rows
                }
                #else
                SearchBar(text: $searchText)
                rows
                #endif
            }
            .padding(.horizontal)
        }
    }

    private var searchHeader: some View {
        SearchBar(text: $searchText)
            .font(.body)
            .foregroundColor(.primary)
            .textCase(.none)
    }

    @ViewBuilder private var rows: some View {
        ForEach(media) { mediaItem in
            switch mediaItem {
            case .movie(let movie):
                NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                    MovieGridItem(movie: movie, showFooter: true)
                        .onAppear {
                            self.mediaItemDidAppear?(mediaItem)
                        }
                }
                .tag(mediaItem)

            case .tvShow(let tvShow):
                NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                    TVShowGridItem(tvShow: tvShow, showFooter: true)
                        .onAppear {
                            self.mediaItemDidAppear?(mediaItem)
                        }
                }
                .tag(mediaItem)

            case .person(let person):
                NavigationLink(destination: PersonDetailsView(id: person.id)) {
                    PersonGridItem(person: person)
                        .onAppear {
                            self.mediaItemDidAppear?(mediaItem)
                        }
                }
                .tag(mediaItem)
            }
        }
    }

}

struct MediaGrid_Previews: PreviewProvider {
    static var previews: some View {
        MediaGrid(searchText: .constant("terminator"), media: [])
    }
}
