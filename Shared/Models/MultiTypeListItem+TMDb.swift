//
//  MultiListItem+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension MultiTypeListItem {

    init(item: TMDb.MultiTypeListResultItem) {
        switch item {
        case .movie(let movie):
            self = .movie(MovieListItem(movie: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShowListItem(tvShow: tvShow))

        case .person(let person):
            self = .person(PersonListItem(person: person))
        }
    }

    static func create(multiTypeItems: [TMDb.MultiTypeListResultItem]) -> [MultiTypeListItem] {
        multiTypeItems.compactMap(Self.init)
    }

}
