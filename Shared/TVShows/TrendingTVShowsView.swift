//
//  TrendingTVShowsView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TrendingTVShowsView: View {

    @ObservedObject private(set) var viewModel: TrendingTVShowsViewModel

    init(viewModel: TrendingTVShowsViewModel = TrendingTVShowsViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        TVShowsList(tvShows: viewModel.tvShows, tvShowDidAppear: tvShowDidAppear)
            .navigationTitle("Trending TV Shows")
    }

}

extension TrendingTVShowsView {

    private func tvShowDidAppear(currentTVShow id: TVShowListItem.ID) {
        viewModel.fetchNextPageIfNeeded(currentTVShow: id)
    }

}

struct TrendingTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        TrendingTVShowsView()
    }

}
