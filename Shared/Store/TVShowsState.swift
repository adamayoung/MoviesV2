//
//  TVShowsState.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

struct TVShowsState: Equatable {

    private static let topLimit = 10

    var tvShowList: [TVShowListItem.ID: TVShowListItem] = [:]

    var isFetchingTrending = false
    var trendingIDs: [TVShowListItem.ID] = []
    var currentTrendingPage = 0
    var isMoreTrendingAvailable = true

    var isFetchingDiscover: Bool = false
    var discoverIDs: [TVShowListItem.ID] = []
    var currentDiscoverPage = 0
    var isMoreDiscoverAvailable = true

    var tvShows: [TVShow.ID: TVShow] = [:]
    var recommendations: [TVShow.ID: [TVShowListItem]] = [:]
    var credits: [TVShow.ID: Credits] = [:]

    var trending: [TVShowListItem] {
        trendingIDs.compactMap { tvShowList[$0] }
    }

    var topTrending: [TVShowListItem] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { tvShowList[$0] }
    }

    var discover: [TVShowListItem] {
        discoverIDs.compactMap { tvShowList[$0] }
    }

    var topDiscover: [TVShowListItem] {
        Array(discoverIDs.prefix(Self.topLimit))
            .compactMap { tvShowList[$0] }
    }

}
