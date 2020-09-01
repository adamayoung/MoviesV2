//
//  MultiTypeList.swift
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

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
            .toolbar { Spacer() }
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        Group {
            #if os(watchOS)
            List {
                SearchBar(text: $searchText)
                rows
            }
            #else
            List(selection: $selection) {
                Section(header: searchHeader) {
                    rows
                }
            }
            .dismissKeyboardOnDrag()
            #endif
        }
        .overlay(Group {
            if isSearching && results.isEmpty {
                ProgressView()
            }
        })
    }

    private var searchHeader: some View {
        SearchBar(text: $searchText)
            .font(.body)
            .foregroundColor(.primary)
            .textCase(.none)
    }

    @ViewBuilder private var rows: some View {
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

}

struct MultiTypeList_Previews: PreviewProvider {

    static var previews: some View {
        MultiTypeList(searchText: .constant(""), isSearching: false, results: [])
    }

}
