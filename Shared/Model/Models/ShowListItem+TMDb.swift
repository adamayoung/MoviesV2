//
//  ShowListItem+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension ShowListItem {

    init(item: TMDb.ShowListResultItem) {
        switch item {
        case .movie(let movie):
            self = .movie(MovieListItem(movie: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShowListItem(tvShow: tvShow))
        }
    }

    static func create(showItems: [TMDb.ShowListResultItem]) -> [ShowListItem] {
        showItems.compactMap(Self.init)
    }

}
