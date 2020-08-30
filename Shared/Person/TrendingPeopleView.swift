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
        PeopleList(people: people, personDidAppear: personDidAppear)
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

    private func personDidAppear(currentPerson person: PersonListItem) {
        //store.fetchNextTrendingPageIfNeeded(currentMovie: movie)
    }

}

struct TrendingPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingPeopleView()
    }
}
