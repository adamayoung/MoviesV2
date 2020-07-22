//
//  CastMember+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension CastMember {

    init(castMember: TMDb.CastMember) {
        let gender: Gender = {
            guard let gender = castMember.gender else {
                return .unknown
            }

            return Gender(gender: gender)
        }()

        self.init(id: castMember.id, castID: castMember.castID, creditID: castMember.creditID, name: castMember.name,
                  character: castMember.character, gender: gender, profilePath: castMember.profilePath,
                  order: castMember.order)
    }

    static func create(castMembers: [TMDb.CastMember]) -> [CastMember] {
        castMembers.map(Self.init)
    }

}
