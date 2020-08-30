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
    var profileURL: URL?

    var body: some View {
        HStack(alignment: .center) {
            PersonImage(url: profileURL, displaySize: .small)

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
        self.init(name: castMember.name, detail: castMember.character, profileURL: castMember.profileURL)
    }

    init(crewMember: CrewMember) {
        self.init(name: crewMember.name, detail: crewMember.department, profileURL: crewMember.profileURL)
    }

}

struct ShowCreditRow_Previews: PreviewProvider {

    static var previews: some View {
        ShowCreditRow(name: "Adam Young", detail: "Director")
    }

}
