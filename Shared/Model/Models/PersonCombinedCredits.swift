//
//  PersonCombinedCredits.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

struct PersonCombinedCredits: Identifiable, Equatable {

    let id: Int
    let cast: [Show]
    let crew: [Show]

    init(id: Int, cast: [Show] = [], crew: [Show] = []) {
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
