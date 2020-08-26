//
//  AppAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum AppAction {

    case movies(MoviesAction)
    case tvShows(TVShowsAction)
    case search(SearchAction)

}
