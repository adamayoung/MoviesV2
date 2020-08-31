//
//  PeopleCollection.swift
//  Movies
//
//  Created by Adam Young on 31/08/2020.
//

import SwiftUI

struct PeopleCollection: View {

    var people: [PersonListItem]
    var itemDidAppear: ((PersonListItem, Int) -> Void)?

    private var offset: Int {
        #if !os(watchOS)
        return 9
        #else
        return 15
        #endif
    }

    var body: some View {
        #if !os(watchOS)
        PeopleGrid(people: people, itemDidAppear: collectionItemDidAppear)
        #else
        PeopleList(people: people, itemDidAppear: collectionItemDidAppear)
        #endif
    }

    private func collectionItemDidAppear(currentItem item: PersonListItem) {
        itemDidAppear?(item, offset)
    }

}

struct PeopleCollection_Previews: PreviewProvider {

    static var previews: some View {
        PeopleCollection(people: [])
    }

}
