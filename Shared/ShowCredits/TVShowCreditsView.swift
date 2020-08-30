//
//  TVShowCreditsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct TVShowCreditsView: View {

    var tvShowID: TVShow.ID

    @EnvironmentObject private var store: AppStore

    private var credits: Credits? {
        store.state.tvShows.credits[tvShowID]
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

extension TVShowCreditsView {

    private func fetch() {
        guard credits == nil else {
            return
        }

        store.send(.tvShows(.fetchCredits(tvShowID: tvShowID)))
    }

}

struct TVShowCreditsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowCreditsView(tvShowID: 1)
    }

}
