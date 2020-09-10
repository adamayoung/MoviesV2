//
//  PeopleState.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

struct PeopleState: Equatable {

    private static let topLimit = 10

    var people: [Person.ID: Person] = [:]

    var knownFor: [Person.ID: [Show]] = [:]

    var isFetchingTrending = false
    var trendingIDs: [Person.ID] = []
    var currentTrendingPage = 0
    var isMoreTrendingAvailable = true

    var credits: [Person.ID: PersonCombinedCredits] = [:]

    var trending: [Person] {
        trendingIDs.compactMap { people[$0] }
    }

    var topTrending: [Person] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { people[$0] }
    }

}
