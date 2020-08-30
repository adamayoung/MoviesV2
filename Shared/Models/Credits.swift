//
//  Credits.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation

struct Credits: Equatable {

    let cast: [CastMember]
    let crew: [CrewMember]

    init(cast: [CastMember] = [], crew: [CrewMember] = []) {
        self.cast = cast
        self.crew = crew
    }

}

extension Credits {

    var isEmpty: Bool {
        cast.isEmpty && crew.isEmpty
    }

}
