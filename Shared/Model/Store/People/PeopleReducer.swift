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

    case .fetchNextTrendingIfNeeded(let currentPerson, let offset):
        return fetchNextTrendingIfNeeded(currentPerson: currentPerson, offset: offset, state: &state)

    case .appendTrending(let people):
        return appendTrending(people: people, state: &state)

    case .fetchPerson(let id):
        return fetchPerson(id: id, environment: environment)

    case .appendPerson(let person):
        return appendPerson(person: person, state: &state)

    case .fetchKnownFor(let personID):
        return fetchKnownFor(personID: personID, environment: environment)

    case .setKnownFor(let shows, let personID):
        return setKnownFor(shows: shows, personID: personID, state: &state)

    case .fetchCredits(let personID):
        return fetchCredits(personID: personID, environment: environment)

    case .setCredits(let credits, let personID):
        return setCredits(credits: credits, personID: personID, state: &state)
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

private func fetchNextTrendingIfNeeded(currentPerson: Person, offset: Int,
                                       state: inout PeopleState) -> AnyPublisher<PeopleAction, Never> {
    let index = state.trendingIDs.firstIndex(where: { $0 == currentPerson.id })
    let thresholdIndex = state.trendingIDs.index(state.trendingIDs.endIndex, offsetBy: -offset)
    guard index == thresholdIndex else {
        return Empty()
            .eraseToAnyPublisher()
    }

    return Just(.fetchTrending)
        .eraseToAnyPublisher()
}

private func appendTrending(people: [Person], state: inout PeopleState) -> AnyPublisher<PeopleAction, Never> {
    state.isFetchingTrending = false
    guard !people.isEmpty else {
        state.isMoreTrendingAvailable = false
        return Empty()
            .eraseToAnyPublisher()
    }

    people.forEach { state.people[$0.id] = $0 }
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

private func fetchKnownFor(personID: Person.ID, environment: AppEnvironment) -> AnyPublisher<PeopleAction, Never> {
    return environment.peopleManager
        .fetchKnownFor(forPerson: personID)
        .map { .setKnownFor(shows: $0, personID: personID) }
        .eraseToAnyPublisher()
}

private func setKnownFor(shows: [Show], personID: Person.ID, state: inout PeopleState) -> AnyPublisher<PeopleAction, Never> {
    state.knownFor[personID] = shows
    return Empty()
        .eraseToAnyPublisher()
}

private func fetchCredits(personID: Person.ID, environment: AppEnvironment) -> AnyPublisher<PeopleAction, Never> {
    return environment.peopleManager
        .fetchCredits(forPerson: personID)
        .map { .setCredits(credits: $0, personID: personID) }
        .eraseToAnyPublisher()
}

private func setCredits(credits: PersonCombinedCredits, personID: Person.ID, state: inout PeopleState) -> AnyPublisher<PeopleAction, Never> {
    state.credits[personID] = credits
    return Empty()
        .eraseToAnyPublisher()
}
