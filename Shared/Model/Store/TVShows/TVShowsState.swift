//
//  TVShowsState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct TVShowsState: Equatable {

    private static let topLimit = 10

    var tvShows: [TVShow.ID: TVShow] = [:]

    var isFetchingTrending = false
    var trendingIDs: [TVShow.ID] = []
    var currentTrendingPage = 0
    var isMoreTrendingAvailable = true

    var isFetchingDiscover: Bool = false
    var discoverIDs: [TVShow.ID] = []
    var currentDiscoverPage = 0
    var isMoreDiscoverAvailable = true

    var recommendationsIDs: [TVShow.ID: [TVShow.ID]] = [:]

    var credits: [TVShow.ID: Credits] = [:]

}

extension TVShowsState {

    var trending: [TVShow] {
        trendingIDs.compactMap { tvShows[$0] }
    }

    var topTrending: [TVShow] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { tvShows[$0] }
    }

    var discover: [TVShow] {
        discoverIDs.compactMap { tvShows[$0] }
    }

    var topDiscover: [TVShow] {
        Array(discoverIDs.prefix(Self.topLimit))
            .compactMap { tvShows[$0] }
    }

    func recommendations(forTVShow tvShowID: TVShow.ID) -> [TVShow]? {
        recommendationsIDs[tvShowID]?.compactMap { tvShows[$0] }
    }

}
