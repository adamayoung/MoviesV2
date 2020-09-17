//
//  TVShowSeasonsView.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import SwiftUI

struct TVShowSeasonsView: View {

    var tvShowID: TVShow.ID

    @EnvironmentObject private var tvShowStore: TVShowStore

    private var seasons: [TVShowSeason]? {
        tvShowStore.seasons(forTVShow: tvShowID)
    }

    var body: some View {
        container
            .onAppear(perform: fetch)
            .navigationTitle("Seasons")
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.large)
        #elseif os(macOS)
        content
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let seasons = self.seasons {
            TVShowSeasonsCollection(tvShowID: tvShowID, seasons: seasons)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        } else {
            ProgressView()
        }
    }

}

extension TVShowSeasonsView {

    private func fetch() {
        tvShowStore.fetchTVShow(withID: tvShowID)
    }

}

struct TVShowSeasonsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowSeasonsView(tvShowID: 1)
    }

}
