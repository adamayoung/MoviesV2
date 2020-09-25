//
//  CastMember.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation

struct CastMember: Identifiable, Equatable {

    let id: Int
    let castID: Int?
    let creditID: String
    let name: String
    let character: String
    let gender: Gender?
    let profileImage: ProfileImageMetadata?
    let order: Int

    init(id: Int, castID: Int? = nil, creditID: String, name: String, character: String, gender: Gender? = nil,
         profileImage: ProfileImageMetadata? = nil, order: Int) {
        self.id = id
        self.castID = castID
        self.creditID = creditID
        self.name = name
        self.character = character
        self.gender = gender
        self.profileImage = profileImage
        self.order = order
    }

}
