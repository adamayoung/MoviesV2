//
//  TrendingPeopleView.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct TrendingPeopleView: View {

    @EnvironmentObject private var personStore: PersonStore

    private var people: [Person] {
        personStore.trending
    }

    var body: some View {
        PeopleCollection(people: people, personDidAppear: personDidAppear)
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
        personStore.fetchTrending()
    }

    private func personDidAppear(currentPerson person: Person, offset: Int) {
        personStore.fetchNextTrendingIfNeeded(currentPerson: person, offset: offset)
    }

}

struct TrendingPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingPeopleView()
    }
}
