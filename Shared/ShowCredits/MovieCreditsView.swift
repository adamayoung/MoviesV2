//
//  MovieCreditsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct MovieCreditsView: View {

    var movieID: Movie.ID

    @EnvironmentObject private var store: AppStore

    private var credits: Credits? {
        store.state.movies.credits[movieID]
    }

    var body: some View {
        container
            .onAppear(perform: fetch)
            .navigationTitle("Cast & Crew")
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
            ShowCreditsList(credits: credits)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension MovieCreditsView {

    private func fetch() {
        guard credits == nil else {
            return
        }

        store.send(.movies(.fetchCredits(movieID: movieID)))
    }

}

struct MovieCreditsView_Previews: PreviewProvider {

    static var previews: some View {
        MovieCreditsView(movieID: 1)
    }

}
