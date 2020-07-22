//
//  SearchResultsList.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct SearchResultsList: View {

    @Binding var searchText: String
    var isSearching: Bool
    var results: [MultiTypeListItem]

    var body: some View {
        List {
            SearchBar(text: $searchText)
            SearchResultRows(results: results)
        }
        .overlay(Group {
            if isSearching && results.isEmpty {
                ProgressView()
            }
        })
        .dismissKeyboardOnDrag()
    }

}

struct SearchResultsList_Previews: PreviewProvider {

    static var previews: some View {
        SearchResultsList(searchText: .constant(""), isSearching: false, results: [])
    }

}
