//
//  AppEnvironment.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct AppEnvironment {

    let moviesManager: MoviesManager
    let peopleManager: PeopleManager
    let searchManager: SearchManager
    let tvShowsManager: TVShowsManager
    let favouritesService: FavouritesService

    init(
        moviesManager: MoviesManager = TMDbMoviesManager(),
        peopleManager: PeopleManager = TMDbPeopleManager(),
        searchManager: SearchManager = TMDbSearchManager(),
        tvShowsManager: TVShowsManager = TMDbTVShowsManager(),
        favouritesService: FavouritesService = CloudKitFavouritesService()
    ) {
        self.moviesManager = moviesManager
        self.peopleManager = peopleManager
        self.searchManager = searchManager
        self.tvShowsManager = tvShowsManager
        self.favouritesService = favouritesService
    }

}
