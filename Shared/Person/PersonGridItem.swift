//
//  PersonGridItem.swift
//  Movies
//
//  Created by Adam Young on 31/08/2020.
//

import SwiftUI

struct PersonGridItem: View {

    var person: Person

    var body: some View {
        VStack {
            PersonImage(imageMetadata: person.profileImage)
            Text(person.name)
                .foregroundColor(.primary)
                .font(.headline)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

}

// struct PersonGridItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PersonGridItem()
//    }
//
// }
