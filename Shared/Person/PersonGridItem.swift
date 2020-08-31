//
//  PersonGridItem.swift
//  Movies
//
//  Created by Adam Young on 31/08/2020.
//

import SwiftUI

struct PersonGridItem: View {

    var person: PersonListItem

    var body: some View {
        VStack {
            PersonImage(url: person.profileURL)
            Text(person.name ?? " ")
                .foregroundColor(.primary)
                .font(.headline)
                .multilineTextAlignment(.center)

            Group {
                if let knownForSummary = person.knownForSummary {
                    Text(knownForSummary)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .foregroundColor(.gray)
            .font(.subheadline)

            Spacer()
        }
    }

}

//struct PersonGridItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PersonGridItem()
//    }
//
//}
