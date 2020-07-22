//
//  TrendingMoviesView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TrendingMoviesView: View {

    @ObservedObject private(set) var viewModel = TrendingMoviesViewModel()

    init(viewModel: TrendingMoviesViewModel = TrendingMoviesViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        MoviesList(movies: viewModel.movies, movieDidAppear: movieDidAppear)
            .navigationTitle("Trending Movies")
    }

}

extension TrendingMoviesView {

    private func movieDidAppear(currentMovie id: Int) {
        viewModel.fetchNextPageIfNeeded(currentMovie: id)
    }

}

struct TrendingMoviesView_Previews: PreviewProvider {

    static var previews: some View {
        TrendingMoviesView()
    }

}
