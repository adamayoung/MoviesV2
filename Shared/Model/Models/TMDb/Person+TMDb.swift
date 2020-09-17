//
//  Person+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension Person {

    init(person: TMDb.Person) {
        let biography: String? = {
            guard let biography = person.biography, !biography.isEmpty else {
                return nil
            }

            return biography
        }()

        let gender: Gender? = {
            guard let gender = person.gender else {
                return nil
            }

            return Gender(gender: gender)
        }()

        self.init(id: person.id, name: person.name, alsoKnownAs: person.alsoKnownAs,
                  knownForDepartment: person.knownForDepartment, biography: biography, birthday: person.birthday,
                  deathday: person.deathday, gender: gender, placeOfBirth: person.placeOfBirth,
                  profileURL: person.profileURL, popularity: person.popularity, imdbId: person.imdbId,
                  homepage: person.homepage)
    }

    static func create(people: [TMDb.Person]) -> [Self] {
        people.map(Self.init)
    }

}

extension TMDb.Person: ProfileURLProviding { }
