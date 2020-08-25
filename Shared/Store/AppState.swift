//
//  AppState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct AppState: Equatable {

    var movies: MoviesState = MoviesState()
    var tvShows: TVShowsState = TVShowsState()
    var search: SearchState = SearchState()

}
