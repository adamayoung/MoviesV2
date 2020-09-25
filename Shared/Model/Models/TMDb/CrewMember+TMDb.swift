//
//  CrewMember+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension CrewMember {

    init(dto: CrewMemberDTO) {
        let gender: Gender = {
            guard let gender = dto.gender else {
                return .unknown
            }

            return Gender(dto: gender)
        }()

        let profileImage = ProfileImageMetadata(profileURLProvider: dto)

        self.init(id: dto.id, creditID: dto.creditID, name: dto.name, job: dto.job, department: dto.department,
                  gender: gender, profileImage: profileImage)
    }

    static func create(dtos: [CrewMemberDTO]) -> [CrewMember] {
        dtos.map(Self.init)
    }

}
