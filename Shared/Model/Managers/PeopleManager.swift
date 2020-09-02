//
//  PeopleManager.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Combine
import Foundation
import TMDb

final class TMDbPeopleManager: PeopleManaging {

    private let personService: PersonService
    private let trendingService: TrendingService

    init(
        personService: PersonService = TMDbPersonService(),
        trendingService: TrendingService = TMDbTrendingService()
    ) {
        self.personService = personService
        self.trendingService = trendingService
    }

    func fetchTrending(page: Int = 1) -> AnyPublisher<[PersonListItem], Never> {
        trendingService.fetchPeople(timeWindow: .day, page: page)
            .map(\.results)
            .map(PersonListItem.create)
            .handleEvents(receiveCompletion: { (comp) in
                switch comp {
                case .failure(let error):
                    print(error)

                default:
                    break
                }
            })
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchPerson(withID id: Person.ID) -> AnyPublisher<Person?, Never> {
        personService.fetchDetails(forPerson: id)
            .map(Person.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func fetchKnownFor(forPerson personID: Person.ID) -> AnyPublisher<[ShowListItem], Never> {
        personService.fetchKnownFor(forPerson: personID)
            .map(ShowListItem.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchCredits(forPerson personID: Person.ID) -> AnyPublisher<PersonCombinedCredits, Never> {
        personService.fetchCombinedCredits(forPerson: personID)
            .map(PersonCombinedCredits.init)
            .replaceError(with: PersonCombinedCredits(id: personID))
            .eraseToAnyPublisher()
    }

}
