//
//  CrewMember+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension CrewMember {

    init(model: TMDb.CrewMember) {
        let gender: Gender = {
            guard let gender = model.gender else {
                return .unknown
            }

            return Gender(model: gender)
        }()

        let profileImage = ProfileImageMetadata(profileURLProvider: model)

        self.init(id: model.id, creditID: model.creditID, name: model.name, job: model.job,
                  department: model.department, gender: gender, profileImage: profileImage)
    }

    static func create(models: [TMDb.CrewMember]) -> [CrewMember] {
        models.map(Self.init)
    }

}
