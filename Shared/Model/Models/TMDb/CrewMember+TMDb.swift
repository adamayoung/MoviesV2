//
//  CrewMember+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension CrewMember {

    init(crewMember: TMDb.CrewMember) {
        let gender: Gender = {
            guard let gender = crewMember.gender else {
                return .unknown
            }

            return Gender(gender: gender)
        }()

        self.init(id: crewMember.id, creditID: crewMember.creditID, name: crewMember.name, job: crewMember.job,
                  department: crewMember.department, gender: gender, profileURL: crewMember.profileURL)
    }

    static func create(crewMembers: [TMDb.CrewMember]) -> [CrewMember] {
        crewMembers.map(Self.init)
    }

}

extension TMDb.CrewMember: ProfileURLProviding { }
