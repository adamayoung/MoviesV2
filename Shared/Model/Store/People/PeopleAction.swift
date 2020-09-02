//
//  PeopleAction.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

enum PeopleAction {

    case fetchTrending
    case fetchNextTrendingIfNeeded(currentPerson: PersonListItem, offset: Int = 15)
    case appendTrending(people: [PersonListItem])
    case fetchPerson(id: Person.ID)
    case appendPerson(person: Person)
    case fetchKnownFor(personID: Person.ID)
    case setKnownFor(shows: [ShowListItem], personID: Person.ID)
    case fetchCredits(personID: Person.ID)
    case setCredits(credits: PersonCombinedCredits, personID: Person.ID)

}
