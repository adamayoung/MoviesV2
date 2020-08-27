//
//  PeopleState.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

struct PeopleState: Equatable {

    private static let topLimit = 10

    var personList: [PersonListItem.ID: PersonListItem] = [:]
    var people: [Person.ID: Person] = [:]

    var isFetchingTrending = false
    var trendingIDs: [PersonListItem.ID] = []
    var currentTrendingPage = 0
    var isMoreTrendingAvailable = true

    var trending: [PersonListItem] {
        trendingIDs.compactMap { personList[$0] }
    }

    var topTrending: [PersonListItem] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { personList[$0] }
    }

}
