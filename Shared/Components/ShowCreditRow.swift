//
//  ShowCreditRow.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct ShowCreditRow: View {

    var name: String
    var detail: String
    var profileImageMetadata: ProfileImageMetadata?

    var body: some View {
        HStack(alignment: .center) {
            PersonImage(imageMetadata: profileImageMetadata, displaySize: .small)

            VStack(alignment: .leading) {
                Text(name)
                    .bold()

                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
    }

}

extension ShowCreditRow {

    init(castMember: CastMember) {
        self.init(name: castMember.name, detail: castMember.character,
                  profileImageMetadata: castMember.profileImage)
    }

    init(crewMember: CrewMember) {
        self.init(name: crewMember.name, detail: crewMember.department,
                  profileImageMetadata: crewMember.profileImage)
    }

}

struct ShowCreditRow_Previews: PreviewProvider {

    static var previews: some View {
        ShowCreditRow(name: "Adam Young", detail: "Director")
    }

}
