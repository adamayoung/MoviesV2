//
//  AppAction.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

enum AppAction {

    case movies(MoviesAction)
    case people(PeopleAction)
    case search(SearchAction)
    case tvShows(TVShowsAction)

}
