//
//  PersonRow.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct PersonRow: View {

    var person: Person

    var body: some View {
        HStack(alignment: .center) {
            PersonImage(url: person.profileURL, displaySize: .medium)

            Text(person.name)
                .font(.headline)
        }
    }

}

struct PersonRow_Previews: PreviewProvider {

    static var previews: some View {
        let person = Person(id: 1, name: "Adam Young")
        return PersonRow(person: person)
    }

}
