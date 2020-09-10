//
//  PeopleManager.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol PeopleManager {

    func fetchTrending(page: Int) -> AnyPublisher<[Person], Never>

    func fetchPerson(withID id: Person.ID) -> AnyPublisher<Person?, Never>

    func fetchKnownFor(forPerson personID: Person.ID) -> AnyPublisher<[Show], Never>

    func fetchCredits(forPerson personID: Person.ID) -> AnyPublisher<PersonCombinedCredits, Never>

}

extension PeopleManager {

    func fetchTrending(page: Int = 1) -> AnyPublisher<[Person], Never> {
        fetchTrending(page: page)
    }

}
