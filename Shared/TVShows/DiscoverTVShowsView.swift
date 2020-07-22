//
//  DiscoverTVShowsView.swift
//  TVShows
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct DiscoverTVShowsView: View {

    @ObservedObject private(set) var viewModel: DiscoverTVShowsViewModel

    init(viewModel: DiscoverTVShowsViewModel = DiscoverTVShowsViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        TVShowsList(tvShows: viewModel.tvShows, tvShowDidAppear: tvShowDidAppear)
            .navigationTitle("Discover TV Shows")
    }

}

extension DiscoverTVShowsView {

    private func tvShowDidAppear(currentTVShow id: TVShowListItem.ID) {
        viewModel.fetchNextPageIfNeeded(currentTVShow: id)
    }

}

struct DiscoverTVShowsView_Previews: PreviewProvider {

    static var previews: some View {
        DiscoverTVShowsView()
    }

}
