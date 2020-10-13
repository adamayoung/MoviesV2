//
//  MediaList.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct MediaList: View {

    @Binding var searchText: String
    var media: [Media]
    var mediaItemDidAppear: ((Media) -> Void)?

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
            .dismissKeyboardOnDrag()
        #endif
    }

    private var content: some View {
        List {
            #if !os(watchOS)
            Section(header: searchHeader) {
                rows
            }
            #else
            SearchBar(text: $searchText)
            rows
            #endif
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
                    MovieRow(movie: movie)
                        .onAppear {
                            self.mediaItemDidAppear?(mediaItem)
                        }
                }
                .tag(mediaItem)

            case .tvShow(let tvShow):
                NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                    TVShowRow(tvShow: tvShow)
                        .onAppear {
                            self.mediaItemDidAppear?(mediaItem)
                        }
                }
                .tag(mediaItem)

            case .person(let person):
                NavigationLink(destination: PersonDetailsView(id: person.id)) {
                    PersonRow(person: person)
                        .onAppear {
                            self.mediaItemDidAppear?(mediaItem)
                        }
                }
                .tag(mediaItem)
            }
        }
    }

}

struct MediaList_Previews: PreviewProvider {

    static var previews: some View {
        MediaList(searchText: .constant(""), media: [])
    }

}
