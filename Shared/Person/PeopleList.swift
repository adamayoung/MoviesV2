//
//  PeopleList.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PeopleList: View {

    var people: [PersonListItem] = []
    var itemDidAppear: ((PersonListItem) -> Void)?

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    private var content: some View {
        List(people) { person in
            NavigationLink(destination: PersonDetailsView(id: person.id)) {
                PersonRow(person: person)
                    .onAppear {
                        self.itemDidAppear?(person)
                    }
            }
        }
    }

}

struct PeopleList_Previews: PreviewProvider {

    static var previews: some View {
        PeopleList()
    }

}
