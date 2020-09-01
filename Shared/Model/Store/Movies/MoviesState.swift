//
//  MoviesState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct MoviesState: Equatable {

    private static let topLimit = 10

    var movieList: [MovieListItem.ID: MovieListItem] = [:]

    var isFetchingTrending = false
    var trendingIDs: [MovieListItem.ID] = []
    var currentTrendingPage = 0
    var isMoreTrendingAvailable = true

    var isFetchingDiscover: Bool = false
    var discoverIDs: [MovieListItem.ID] = []
    var currentDiscoverPage = 0
    var isMoreDiscoverAvailable = true

    var favouriteIDs: [MovieListItem.ID] = []

    var movies: [Movie.ID: Movie] = [:]
    var recommendations: [Movie.ID: [MovieListItem]] = [:]
    var credits: [Movie.ID: Credits] = [:]

    var trending: [MovieListItem] {
        trendingIDs.compactMap { movieList[$0] }
    }

    var topTrending: [MovieListItem] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { movieList[$0] }
    }

    var discover: [MovieListItem] {
        discoverIDs.compactMap { movieList[$0] }
    }

    var topDiscover: [MovieListItem] {
        Array(discoverIDs.prefix(Self.topLimit))
            .compactMap { movieList[$0] }
    }

    var favourites: [MovieListItem] {
        favouriteIDs.compactMap { movieList[$0] }
    }

    func isFavourite(_ movieID: Movie.ID) -> Bool {
        favouriteIDs.contains(movieID)
    }



}
