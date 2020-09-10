//
//  MoviesState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct MoviesState: Equatable {

    private static let topLimit = 10

    var movies: [Movie.ID: Movie] = [:]

    var isFetchingTrending = false
    var trendingIDs: [Movie.ID] = []
    var currentTrendingPage = 0
    var isMoreTrendingAvailable = true

    var isFetchingDiscover: Bool = false
    var discoverIDs: [Movie.ID] = []
    var currentDiscoverPage = 0
    var isMoreDiscoverAvailable = true

    var favouriteIDs: [Movie.ID] = []

    var recommendationsIDs: [Movie.ID: [Movie.ID]] = [:]

    var credits: [Movie.ID: Credits] = [:]

}

extension MoviesState {

    var trending: [Movie] {
        trendingIDs.compactMap { movies[$0] }
    }

    var topTrending: [Movie] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { movies[$0] }
    }

    var discover: [Movie] {
        discoverIDs.compactMap { movies[$0] }
    }

    var topDiscover: [Movie] {
        Array(discoverIDs.prefix(Self.topLimit))
            .compactMap { movies[$0] }
    }

    var favourites: [Movie] {
        favouriteIDs.compactMap { movies[$0] }
    }

    var topFavourites: [Movie] {
        Array(favouriteIDs.prefix(Self.topLimit))
            .compactMap { movies[$0] }
    }

    func isFavourite(_ movieID: Movie.ID) -> Bool {
        favouriteIDs.contains(movieID)
    }

    func recommendations(forMovie movieID: Movie.ID) -> [Movie]? {
        recommendationsIDs[movieID]?.compactMap { movies[$0] }
    }

}
