//
//  PersonDetails.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonDetails: View {

    var person: Person

    var body: some View {
        #if os(iOS)
        content
            .listStyle(InsetGroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            Section(header: PersonDetailsHeader(person: person)) {
                EmptyView()
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, -20)

            if let biography = person.biography {
                PersonBiographySection(name: person.name, biography: biography)
            }

            if PersonPersonalDetailsSection.hasPersonalDetails(person: person) {
                PersonPersonalDetailsSection(person: person)
            }
        }
    }

}

struct PersonDetails_Previews: PreviewProvider {

    static var previews: some View {
        let person = Person(id: 1, name: "Adam Young", biography: "Adam is an iOS Developer", gender: .male, popularity: 10, imdbId: "abc123")

        return NavigationView {
            PersonDetails(person: person)
        }
        .navigationTitle(person.name)
    }

}
