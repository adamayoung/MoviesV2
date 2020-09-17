//
//  Credits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Credits {

    init(cast: [TMDb.CastMember], crew: [TMDb.CrewMember]) {
        let cast = CastMember.create(castMembers: cast)
        let crew = CrewMember.create(crewMembers: crew)

        self.init(cast: cast, crew: crew)
    }

    init(credits: TMDb.ShowCredits) {
        self.init(cast: credits.cast, crew: credits.crew)
    }

}
