//
//  SearchState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct SearchState: Equatable {

    var isSearching = false
    var query: String = ""
    var results: [MultiTypeListItem] = []

}
