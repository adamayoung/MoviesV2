//
//  Person+ManagedObject.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import CoreData

extension Person {

    init?(person: FavouritePerson) {
        guard let name = person.name else {
            return nil
        }

        let profileImage: ProfileImageMetadata? = {
            guard
                let url = person.profileURL,
                let lowDataURL = person.profileLowDataURL,
                let originalURL = person.profileOriginalURL
            else {
                return nil
            }

            return ProfileImageMetadata(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
        }()

        self.init(id: Int(person.personID), name: name, profileImage: profileImage)
    }

}

extension FavouritePerson {

    convenience init(context: NSManagedObjectContext, person: Person) {
        self.init(context: context)
        self.personID = Int64(person.id)
        self.name = person.name
        self.profileURL = person.profileImage?.url
        self.profileLowDataURL = person.profileImage?.lowDataURL
        self.profileOriginalURL = person.profileImage?.originalURL
        self.createdAt = Date()
    }

}
