//
//  PeopleGrid.swift
//  Movies
//
//  Created by Adam Young on 31/08/2020.
//

import SwiftUI

struct PeopleGrid: View {

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    var people: [PersonListItem] = []
    var itemDidAppear: ((PersonListItem) -> Void)?

    private let columnsCompact: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    private let columnsRegular: [GridItem] = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    private var columns: [GridItem] {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return columnsCompact
        } else {
            return columnsRegular
        }
        #else
        return columnsRegular
        #endif
    }

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

    var content: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(people) { person in
                    NavigationLink(destination: PersonDetailsView(id: person.id)) {
                        PersonGridItem(person: person)
                            .onAppear {
                                self.itemDidAppear?(person)
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

}

struct PeopleGrid_Previews: PreviewProvider {

    static var previews: some View {
        PeopleGrid(people: [])
    }

}
