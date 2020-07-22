//
//  CreditRow.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct CreditRow: View {

    var name: String
    var detail: String
    var profileImagePath: URL?

    init(name: String, detail: String, profileImagePath: URL? = nil) {
        self.name = name
        self.detail = detail
        self.profileImagePath = profileImagePath
    }

    var body: some View {
        HStack(alignment: .center) {
            PersonImage(path: profileImagePath, displaySize: .small)

            VStack(alignment: .leading) {
                Text(name)
                    .bold()

                Text(detail)
                    .foregroundColor(.secondary)
            }
        }
    }

}

extension CreditRow {

    init(castMember: CastMember) {
        self.init(name: castMember.name, detail: castMember.character, profileImagePath: castMember.profilePath)
    }

    init(crewMember: CrewMember) {
        self.init(name: crewMember.name, detail: crewMember.department, profileImagePath: crewMember.profilePath)
    }

}

struct CreditRow_Previews: PreviewProvider {

    static var previews: some View {
        CreditRow(name: "Adam Young", detail: "Director", profileImagePath: nil)
    }

}
