//
//  TrendingPeopleView.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct TrendingPeopleView: View {

    @EnvironmentObject private var store: AppStore

    private var people: [PersonListItem] {
        store.state.people.trending
    }

    var body: some View {
        PeopleCollection(people: people, itemDidAppear: itemDidAppear)
            .overlay(Group {
                if people.isEmpty {
                    ProgressView()
                }
            })
            .onAppear(perform: fetch)
            .navigationTitle("Trending People")
    }

}

extension TrendingPeopleView {

    private func fetch() {
        guard people.isEmpty else {
            return
        }

        store.send(.people(.fetchTrending))
    }

    private func itemDidAppear(currentItem item: PersonListItem, offset: Int) {
        store.send(.people(.fetchNextTrendingIfNeeded(currentPerson: item, offset: offset)))
    }

}

struct TrendingPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingPeopleView()
    }
}
