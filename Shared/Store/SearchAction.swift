//
//  SearchAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum SearchAction {

    case search(query: String)
    case setResults(results: [MultiTypeListItem], query: String)

}
