//
//  CastMember+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension CastMember {

    init(model: TMDb.CastMember) {
        let gender: Gender = {
            guard let gender = model.gender else {
                return .unknown
            }

            return Gender(model: gender)
        }()

        let profileImage = ProfileImageMetadata(profileURLProvider: model)

        self.init(id: model.id, castID: model.castID, creditID: model.creditID, name: model.name,
                  character: model.character, gender: gender, profileImage: profileImage, order: model.order)
    }

    static func create(models: [TMDb.CastMember]) -> [CastMember] {
        models.map(Self.init)
    }

}
