//
//  PersonCombinedCredits.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

struct PersonCombinedCredits: Identifiable, Equatable {

    let id: Int
    let cast: [ShowListItem]
    let crew: [ShowListItem]

    init(id: Int, cast: [ShowListItem] = [], crew: [ShowListItem] = []) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }

}

extension PersonCombinedCredits {

    var isEmpty: Bool {
        cast.isEmpty && crew.isEmpty
    }

}
