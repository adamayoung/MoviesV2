//
//  PeopleAction.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

enum PeopleAction {

    case fetchTrending
    case fetchNextTrendingIfNeeded(currentPerson: Person, offset: Int = 15)
    case appendTrending(people: [Person])
    case fetchPerson(id: Person.ID)
    case appendPerson(person: Person)
    case fetchKnownFor(personID: Person.ID)
    case setKnownFor(shows: [Show], personID: Person.ID)
    case fetchCredits(personID: Person.ID)
    case setCredits(credits: PersonCombinedCredits, personID: Person.ID)

}
