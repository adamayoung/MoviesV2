//
//  SearchResultsList.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct MultiTypeList: View {

    @State private var selection: MultiTypeListItem?

    @Binding var searchText: String
    var isSearching: Bool
    var results: [MultiTypeListItem]

    var content: some View {
        List(selection: $selection) {
            SearchBar(text: $searchText)

            ForEach(results) { result in
                switch result {
                case .movie(let movie):
                    NavigationLink(
                        destination: MovieDetailsView(id: movie.id),
                        tag: result,
                        selection: $selection
                    ) {
                        MovieRow(movie: movie)
                    }
                    .tag(result)

                case .tvShow(let tvShow):
                    NavigationLink(
                        destination: TVShowDetailsView(id: tvShow.id),
                        tag: result,
                        selection: $selection
                    ) {
                        TVShowRow(tvShow: tvShow)
                    }
                    .tag(result)

                case .person(let person):
                    NavigationLink(
                        destination: PersonDetailsView(id: person.id),
                        tag: result,
                        selection: $selection
                    ) {
                        PersonRow(person: person)
                    }
                    .tag(result)
                }
            }
        }
        .overlay(Group {
            if isSearching && results.isEmpty {
                ProgressView()
            }
        })
        .dismissKeyboardOnDrag()
    }

    var body: some View {
        #if os(iOS)
        content
        #else
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
            .toolbar { Spacer() }
        #endif
    }

}

struct SearchResultsList_Previews: PreviewProvider {

    static var previews: some View {
        MultiTypeList(searchText: .constant(""), isSearching: false, results: [])
    }

}
