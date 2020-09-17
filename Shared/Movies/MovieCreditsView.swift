//
//  MovieCreditsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct MovieCreditsView: View {

    var movieID: Movie.ID

    @EnvironmentObject private var movieStore: MovieStore

    private var credits: Credits? {
        movieStore.credits(forMovie: movieID)
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
        movieStore.fetchCredits(forMovie: movieID)
    }

}

struct MovieCreditsView_Previews: PreviewProvider {

    static var previews: some View {
        MovieCreditsView(movieID: 1)
    }

}
