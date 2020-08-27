//
//  PersonPersonalDetailsView.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonPersonalDetailsView: View {

    var person: Person

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let age = person.age {
                    VStack(alignment: .leading) {
                        Text("Age")
                        Group {
                            Text("\(age)") + Text(person.deathday != nil ? " (Died)" : "")
                        }
                        .foregroundColor(.secondary)
                    }

                    Divider()
                }

                if let birthday = person.birthday {
                    VStack(alignment: .leading) {
                        Text("Birthday")
                        Text("\(birthday, formatter: DateFormatter.longDate)")
                            .foregroundColor(.secondary)
                    }

                    Divider()
                }

                if let deathday = person.deathday {
                    VStack(alignment: .leading) {
                        Text("Died")
                        Text("\(deathday, formatter: DateFormatter.longDate)")
                            .foregroundColor(.secondary)
                    }

                    Divider()
                }

                if let placeOfBirth = person.placeOfBirth {
                    VStack(alignment: .leading) {
                        Text("Place of birth")
                        Text("\(placeOfBirth)")
                            .foregroundColor(.secondary)
                    }

                    Divider()
                }

                if let knownForDepartment = person.knownForDepartment {
                    VStack(alignment: .leading) {
                        Text("Known for")
                        Text("\(knownForDepartment)")
                            .foregroundColor(.secondary)
                    }

                    Divider()
                }

                HStack {
                    Spacer()
                }
            }
            .multilineTextAlignment(.leading)
        }
        .navigationTitle("Personal Details")
    }
}

struct PersonPersonalDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        let person = Person(id: 1, name: "Adam Young", biography: "Adam is an iOS Developer", gender: .male, popularity: 10, imdbId: "abc123")

        return PersonPersonalDetailsView(person: person)
    }

}
