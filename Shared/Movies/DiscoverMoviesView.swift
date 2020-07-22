//
//  DiscoverMoviesView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct DiscoverMoviesView: View {

    @ObservedObject private(set) var viewModel: DiscoverMoviesViewModel

    init(viewModel: DiscoverMoviesViewModel = DiscoverMoviesViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        MoviesList(movies: viewModel.movies, movieDidAppear: movieDidAppear)
            .navigationTitle("Discover Movies")
    }

}

extension DiscoverMoviesView {

    private func movieDidAppear(currentMovie id: Int) {
        viewModel.fetchNextPageIfNeeded(currentMovie: id)
    }

}

struct DiscoverMoviesView_Previews: PreviewProvider {

    static var previews: some View {
        DiscoverMoviesView()
    }

}
