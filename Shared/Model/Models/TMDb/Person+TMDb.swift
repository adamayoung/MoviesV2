//
//  Person+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension Person {

    init(dto: PersonDTO) {
        let biography: String? = {
            guard let biography = dto.biography, !biography.isEmpty else {
                return nil
            }

            return biography
        }()

        let gender: Gender? = {
            guard let gender = dto.gender else {
                return nil
            }

            return Gender(dto: gender)
        }()

        let profileImage = ProfileImageMetadata(profileURLProvider: dto)

        self.init(id: dto.id, name: dto.name, alsoKnownAs: dto.alsoKnownAs, knownForDepartment: dto.knownForDepartment,
                  biography: biography, birthday: dto.birthday, deathday: dto.deathday, gender: gender,
                  placeOfBirth: dto.placeOfBirth, profileImage: profileImage, popularity: dto.popularity,
                  imdbID: dto.imdbID, homepageURL: dto.homepageURL)
    }

    static func create(dtos: [PersonDTO]) -> [Self] {
        dtos.map(Self.init)
    }

}
