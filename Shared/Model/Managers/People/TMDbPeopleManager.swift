//
//  TMDbPeopleManager.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Combine
import Foundation
import TMDb

final class TMDbPeopleManager: PeopleManager {

    private let tmdb: MovieTVShowAPI

    init(tmdb: MovieTVShowAPI = TMDbAPI.shared) {
        self.tmdb = tmdb
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[Person], Never> {
        tmdb.trendingPeoplePublisher(page: page)
            .map(\.results)
            .map(Person.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchPerson(withID id: Person.ID) -> AnyPublisher<Person?, Never> {
        tmdb.detailsPublisher(forPerson: id)
            .map(Person.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchKnownFor(forPerson personID: Person.ID) -> AnyPublisher<[Show], Never> {
        tmdb.knownForPublisher(forPerson: personID)
            .map(Show.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchCredits(forPerson personID: Person.ID) -> AnyPublisher<PersonCombinedCredits, Never> {
        tmdb.combinedCreditsPublisher(forPerson: personID)
            .map(PersonCombinedCredits.init)
            .replaceError(with: PersonCombinedCredits(id: personID))
            .eraseToAnyPublisher()
    }

}
