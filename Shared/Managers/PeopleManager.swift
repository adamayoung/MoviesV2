//
//  PeopleManager.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Combine
import Foundation
import TMDb

protocol PeopleManaging {

    func fetchTrending(page: Int) -> AnyPublisher<[PersonListItem], Never>

    func fetchPerson(withID id: Person.ID) -> AnyPublisher<Person?, Never>

}

extension PeopleManaging {

    func fetchTrending(page: Int = 1) -> AnyPublisher<[PersonListItem], Never> {
        fetchTrending(page: page)
    }

}

final class PeopleManager: PeopleManaging {

    private let personService: PersonService

    init(personService: PersonService = TMDbPersonService()) {
        self.personService = personService
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[PersonListItem], Never> {
        personService.fetchTrending(timeWindow: .day, page: page)
            .map(\.results)
            .map(PersonListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchPerson(withID id: Person.ID) -> AnyPublisher<Person?, Never> {
        personService.fetch(id: id)
            .map(Person.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

}
