//
//  Credits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Credits {

    init(credits: TMDb.Credits) {
        let cast = CastMember.create(castMembers: credits.cast)
        let crew = CrewMember.create(crewMembers: credits.crew)

        self.init(id: credits.id, cast: cast, crew: crew)
    }

}
