//
//  PersonListItem+TMDb.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import Foundation
import TMDb

extension PersonListItem {

    init(person: TMDb.PersonListResultItem) {
        let knownFor: [KnownForItem]? = {
            guard let knownFor = person.knownFor else {
                return nil
            }

            return KnownForItem.create(knownFor: knownFor)
        }()

        self.init(id: person.id, name: person.name, profilePath: person.profilePath, knownFor: knownFor,
                  popularity: person.popularity)
    }

    static func create(people: [TMDb.PersonListResultItem]) -> [PersonListItem] {
        people.map(Self.init)
    }

}

extension PersonListItem.KnownForItem {

    init(knownForItem: TMDb.PersonListResultItem.KnownForItem) {
        switch knownForItem {
        case .movie(let movie):
            self = .movie(MovieListItem(movie: movie))

        case .tvShow(let tvShow):
            self = .tvShow(TVShowListItem(tvShow: tvShow))
        }
    }

    static func create(knownFor: [TMDb.PersonListResultItem.KnownForItem]) -> [PersonListItem.KnownForItem] {
        knownFor.map(Self.init)
    }

}
