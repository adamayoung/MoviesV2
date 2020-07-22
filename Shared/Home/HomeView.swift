//
//  HomeView.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI
import TMDb

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        HomeList(trendingMovies: viewModel.trendingMovies, discoverMovies: viewModel.discoverMovies,
                 trendingTVShows: viewModel.trendingTVShows, discoverTVShows: viewModel.discoverTVShows)
        .navigationTitle("Home")
    }

}

struct OverviewView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView()
    }

}
