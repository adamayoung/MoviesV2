//
//  PersonCombinedCredits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension PersonCombinedCredits {

    init(dto: PersonCombinedCreditsDTO) {
        let cast = Show.create(dtos: dto.cast)
        let crew = Show.create(dtos: dto.crew)

        self.init(id: dto.id, cast: cast, crew: crew)
    }

}
