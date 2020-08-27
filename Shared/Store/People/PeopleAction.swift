//
//  PeopleAction.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

enum PeopleAction {

    case fetchTrending
    case appendTrending(people: [PersonListItem])
    case fetchPerson(id: Person.ID)
    case appendPerson(person: Person)

}
