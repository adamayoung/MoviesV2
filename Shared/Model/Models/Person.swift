//
//  Person.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation

struct Person: Identifiable, Equatable {

    let id: Int
    let name: String
    let alsoKnownAs: [String]?
    let knownForDepartment: String?
    let biography: String?
    let birthday: Date?
    let deathday: Date?
    let gender: Gender?
    let placeOfBirth: String?
    let profileImage: ProfileImageMetadata?
    let popularity: Double?
    let imdbID: String?
    let homepageURL: URL?

    var age: Int? {
        guard let birthday = birthday else {
            return nil
        }

        let toDate = deathday ?? Date()
        let components = Calendar.current.dateComponents([.year], from: birthday, to: toDate)
        return components.year
    }

    init(id: Int, name: String, alsoKnownAs: [String]? = nil, knownForDepartment: String? = nil,
         biography: String? = nil, birthday: Date? = nil, deathday: Date? = nil, gender: Gender? = nil,
         placeOfBirth: String? = nil, profileImage: ProfileImageMetadata? = nil, popularity: Double? = nil,
         imdbID: String? = nil, homepageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.alsoKnownAs = alsoKnownAs
        self.knownForDepartment = knownForDepartment
        self.biography = biography
        self.birthday = birthday
        self.deathday = deathday
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.profileImage = profileImage
        self.popularity = popularity
        self.imdbID = imdbID
        self.homepageURL = homepageURL
    }

}
