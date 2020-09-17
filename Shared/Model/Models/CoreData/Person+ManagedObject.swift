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

        self.init(id: Int(person.personID), name: name, profileURL: person.profileURL)
    }

}

extension FavouritePerson {

    convenience init(context: NSManagedObjectContext, person: Person) {
        self.init(context: context)
        self.personID = Int64(person.id)
        self.name = person.name
        self.profileURL = person.profileURL
        self.createdAt = Date()
    }

}
