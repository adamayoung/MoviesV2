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
    let profilePath: URL?
    let order: Int

    public init(id: Int, castID: Int? = nil, creditID: String, name: String, character: String, gender: Gender? = nil,
                profilePath: URL? = nil, order: Int) {
        self.id = id
        self.castID = castID
        self.creditID = creditID
        self.name = name
        self.character = character
        self.gender = gender
        self.profilePath = profilePath
        self.order = order
    }

}
