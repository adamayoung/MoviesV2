//
//  Person+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension Person {

    init(model: TMDb.Person) {
        let biography: String? = {
            guard let biography = model.biography, !biography.isEmpty else {
                return nil
            }

            return biography
        }()

        let gender: Gender? = {
            guard let gender = model.gender else {
                return nil
            }

            return Gender(model: gender)
        }()

        let profileImage = ProfileImageMetadata(profileURLProvider: model)

        self.init(id: model.id, name: model.name, alsoKnownAs: model.alsoKnownAs,
                  knownForDepartment: model.knownForDepartment, biography: biography, birthday: model.birthday,
                  deathday: model.deathday, gender: gender, placeOfBirth: model.placeOfBirth,
                  profileImage: profileImage, popularity: model.popularity, imdbID: model.imdbID,
                  homepageURL: model.homepageURL)
    }

    static func create(models: [TMDb.Person]) -> [Self] {
        models.map(Self.init)
    }

}
