//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MovieDetailsView: View {

    @ObservedObject private(set) var viewModel: MovieDetailsViewModel

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }

    init(id: Movie.ID) {
        self.init(viewModel: MovieDetailsViewModel(id: id))
    }

    var body: some View {
        #if os(iOS)
        return content
            .navigationBarTitleDisplayMode(.inline)
        #else
        return content
        #endif
    }

    private var content: some View {
        Group {
            if let movie = viewModel.movie, let credits = viewModel.credits,
               let recommendations = viewModel.recommendations {
                MovieDetails(movie: movie, credits: credits, recommendations: recommendations)
            } else {
                ProgressView("Hang in there...")
            }
        }
        .onAppear(perform: fetch)
        .navigationTitle(viewModel.movie?.title ?? "")
    }

}

extension MovieDetailsView {

    private func fetch() {
        viewModel.fetch()
    }

}

//struct MovieDetailsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MovieDetailsView(id: 1)
//    }
//
//}
