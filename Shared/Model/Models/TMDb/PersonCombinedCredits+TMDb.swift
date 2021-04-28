//
//  PersonCombinedCredits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension PersonCombinedCredits {

    init(model: TMDb.PersonCombinedCredits) {
        let cast = Show.create(models: model.cast)
        let crew = Show.create(models: model.crew)

        self.init(id: model.id, cast: cast, crew: crew)
    }

}
