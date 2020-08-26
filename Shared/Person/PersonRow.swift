//
//  PersonRow.swift
//  Movies
//
//  Created by Adam Young on 21/07/2020.
//

import SwiftUI

struct PersonRow: View {

    var person: PersonListItem

    var body: some View {
        HStack(alignment: .center) {
            PersonImage(url: person.profileURL, displaySize: .small)

            VStack(alignment: .leading) {
                Text(person.name ?? " ")
                    .font(.headline)

                Group {
                    if let knownForSummary = knownForSummary {
                        Text(knownForSummary)
                            .foregroundColor(.secondary)
                    }
                }
                .foregroundColor(.gray)
                .font(.subheadline)
            }
        }
    }

    private var knownForSummary: String? {
        guard let knownForItem = person.knownFor?.first else {
            return nil
        }

        var summary = knownForItem.title
        if let date = knownForItem.date {
            summary += " (\(DateFormatter.year.string(from: date)))"
        }

        return summary
    }

}

struct PersonRow_Previews: PreviewProvider {

    static var previews: some View {
        let person = PersonListItem(id: 1, name: "Adam Young")
        return PersonRow(person: person)
    }

}
