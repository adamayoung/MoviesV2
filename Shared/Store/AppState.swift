//
//  AppState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct AppState: Equatable {

    var movies: MoviesState = MoviesState()
    var people: PeopleState = PeopleState()
    var search: SearchState = SearchState()
    var tvShows: TVShowsState = TVShowsState()

}
