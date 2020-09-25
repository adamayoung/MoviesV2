//
//  CastMember+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension CastMember {

    init(dto: CastMemberDTO) {
        let gender: Gender = {
            guard let gender = dto.gender else {
                return .unknown
            }

            return Gender(dto: gender)
        }()

        let profileImage = ProfileImageMetadata(profileURLProvider: dto)

        self.init(id: dto.id, castID: dto.castID, creditID: dto.creditID, name: dto.name, character: dto.character,
                  gender: gender, profileImage: profileImage, order: dto.order)
    }

    static func create(dtos: [CastMemberDTO]) -> [CastMember] {
        dtos.map(Self.init)
    }

}
