//
//  PersonPersonalDetailsSection.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonPersonalDetailsSection: View {

    static func hasPersonalDetails(person: Person) -> Bool {
        if person.birthday != nil {
            return true
        }

        if person.deathday != nil {
            return true
        }

        if person.placeOfBirth != nil {
            return true
        }

        return false
    }

    var person: Person

    var body: some View {
        #if !os(watchOS)
        Section(header: Text("Personal details").listSectionHeaderStyle()) {
            content
        }
        #else
        content
        #endif
    }

    #if !os(watchOS)
    @ViewBuilder private var content: some View {
        if let age = person.age {
            HStack {
                Text("Age")
                Spacer()
                Group {
                    Text("\(age)") + Text(person.deathday != nil ? " (Died)" : "")
                }
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)

            }
        }

        if let birthday = person.birthday {
            HStack {
                Text("Birthday")
                Spacer()
                Text("\(birthday, formatter: DateFormatter.longDate)")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }

        if let deathday = person.deathday {
            HStack {
                Text("Died")
                Spacer()
                Text("\(deathday, formatter: DateFormatter.longDate)")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }

        if let placeOfBirth = person.placeOfBirth {
            HStack {
                Text("Place of birth")
                Spacer()
                Text("\(placeOfBirth)")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    #endif

    #if os(watchOS)
    private var content: some View {
        NavigationLink(destination: PersonPersonalDetailsView(person: person)) {
            HStack {
                Spacer()
                Text("Personal details")
                Spacer()
            }
        }
    }
    #endif
}

// struct PersonPersonalDetailsSection_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonPersonalDetailsSection()
//    }
// }
