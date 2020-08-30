//
//  AppEnvironment.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct AppEnvironment {

    let moviesManager: MoviesManaging = MoviesManager()
    let peopleManager: PeopleManaging = PeopleManager()
    let searchManager: SearchManaging = SearchManager()
    let tvShowsManager: TVShowsManaging = TVShowsManager()

}
