//
//  CreditsList.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct CreditsList: View {

    var credits: Credits

    var body: some View {
        #if os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List {
            if !credits.cast.isEmpty {
                Section(header: Text("Cast")) {
                    castSection
                }
            }

            if !credits.crew.isEmpty {
                Section(header: Text("Crew")) {
                    crewSection
                }
            }
        }
    }

    @ViewBuilder private var castSection: some View {
        ForEach(credits.cast, id: \.creditID) { castMember in
            NavigationLink(destination: PersonDetailsView(id: castMember.id)) {
                CreditRow(castMember: castMember)
            }
        }
    }

    @ViewBuilder private var crewSection: some View {
        ForEach(credits.crew, id: \.creditID) { crewMember in
            NavigationLink(destination: PersonDetailsView(id: crewMember.id)) {
                CreditRow(crewMember: crewMember)
            }
        }
    }

}

struct CreditsList_Previews: PreviewProvider {

    static var previews: some View {
        CreditsList(credits: Credits(id: 1))
    }

}
