//
//  ComplicationType.swift
//  Movies (watchOS Extension)
//
//  Created by Adam Young on 12/10/2020.
//

import Foundation

enum ComplicationType: String {

    case trendingMovie = "TrendingMovie"
    case trendingTVShow = "TrendingTVShow"

}

extension ComplicationType {

    var displayName: String {
        switch self {
        case .trendingMovie:
            return "Trending Movie"

        case .trendingTVShow:
            return "Trending TV Show"
        }
    }

}
