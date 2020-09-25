//
//  Credits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Credits {

    init(castDTOs: [CastMemberDTO], crewDTOs: [CrewMemberDTO]) {
        let cast = CastMember.create(dtos: castDTOs)
        let crew = CrewMember.create(dtos: crewDTOs)

        self.init(cast: cast, crew: crew)
    }

    init(dto: ShowCreditsDTO) {
        self.init(castDTOs: dto.cast, crewDTOs: dto.crew)
    }

}
