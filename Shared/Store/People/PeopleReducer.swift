//
//  PeopleReducer.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Combine
import Foundation

func peopleReducer(state: inout PeopleState, action: PeopleAction, environment: AppEnvironment) -> AnyPublisher<PeopleAction, Never> {
    switch action {
    case .fetchTrending:
        return fetchTrending(state: &state, environment: environment)

    case .appendTrending(let people):
        return appendTrending(people: people, state: &state)

    case .fetchPerson(let id):
        return fetchPerson(id: id, environment: environment)

    case .appendPerson(let person):
        return appendPerson(person: person, state: &state)
    }
}

private func fetchTrending(state: inout PeopleState, environment: AppEnvironment) -> AnyPublisher<PeopleAction, Never> {
    guard !state.isFetchingTrending, state.isMoreTrendingAvailable else {
        return Empty()
            .eraseToAnyPublisher()
    }

    state.isFetchingTrending = true
    state.currentTrendingPage += 1

    return environment.peopleManager
        .fetchTrending(page: state.currentTrendingPage)
        .map { .appendTrending(people: $0) }
        .eraseToAnyPublisher()
}

private func appendTrending(people: [PersonListItem], state: inout PeopleState) -> AnyPublisher<PeopleAction, Never> {
    state.isFetchingTrending = false
    guard !people.isEmpty else {
        state.isMoreTrendingAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    people.forEach { state.personList[$0.id] = $0 }
    state.trendingIDs.append(contentsOf: people.map(\.id))
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchPerson(id: Person.ID, environment: AppEnvironment) -> AnyPublisher<PeopleAction, Never> {
    return environment.peopleManager
        .fetchPerson(withID: id)
        .filter { $0 != nil }
        .map { $0! }
        .map { .appendPerson(person: $0) }
        .eraseToAnyPublisher()
}

private func appendPerson(person: Person, state: inout PeopleState) -> AnyPublisher<PeopleAction, Never> {
    state.people[person.id] = person
    return Empty()
        .eraseToAnyPublisher()
}
