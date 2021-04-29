//
//  Credits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Credits {

    init(castModels: [TMDb.CastMember], crewModels: [TMDb.CrewMember]) {
        let cast = CastMember.create(models: castModels)
        let crew = CrewMember.create(models: crewModels)

        self.init(cast: cast, crew: crew)
    }

    init(model: TMDb.ShowCredits) {
        self.init(castModels: model.cast, crewModels: model.crew)
    }

}
