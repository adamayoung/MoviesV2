//
//  Credits.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation

struct Credits: Identifiable, Equatable {

    let id: Int
    let cast: [CastMember]
    let crew: [CrewMember]

    init(id: Int, cast: [CastMember] = [], crew: [CrewMember] = []) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }

}

extension Credits {

    var isEmpty: Bool {
        cast.isEmpty && crew.isEmpty
    }

}
