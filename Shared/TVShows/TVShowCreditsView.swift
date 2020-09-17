//
//  TVShowCreditsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct TVShowCreditsView: View {

    var tvShowID: TVShow.ID

    @EnvironmentObject private var tvShowStore: TVShowStore

    private var credits: Credits? {
        tvShowStore.credits(forTVShow: tvShowID)
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
        tvShowStore.fetchCredits(forTVShow: tvShowID)
    }

}

struct TVShowCreditsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowCreditsView(tvShowID: 1)
    }

}
