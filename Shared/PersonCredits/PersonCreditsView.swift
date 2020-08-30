//
//  PersonCreditsView.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import SwiftUI

struct PersonCreditsView: View {

    var personID: Person.ID

    @EnvironmentObject private var store: AppStore

    private var credits: PersonCombinedCredits? {
        store.state.people.credits[personID]
    }

    var body: some View {
        container
            .onAppear(perform: fetch)
            .navigationTitle("Filmography")
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.large)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let credits = self.credits {
            PersonCreditsList(credits: credits)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension PersonCreditsView {

    private func fetch() {
        guard credits == nil else {
            return
        }

        store.send(.people(.fetchCredits(personID: personID)))
    }

}

struct PersonCreditsView_Previews: PreviewProvider {

    static var previews: some View {
        MovieCreditsView(movieID: 1)
    }

}
