//
//  TVShowDetailsView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowDetailsView: View {

    @ObservedObject private(set) var viewModel: TVShowDetailsViewModel

    init(viewModel: TVShowDetailsViewModel) {
        self.viewModel = viewModel
    }

    init(id: TVShow.ID) {
        self.init(viewModel: TVShowDetailsViewModel(id: id))
    }

    var body: some View {
        #if os(watchOS)
        content
        #else
        content
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var content: some View {
        Group {
            if let tvShow = viewModel.tvShow, let credits = viewModel.credits {
                TVShowDetails(tvShow: tvShow, credits: credits)
            } else {
                ProgressView("Hang in there...")
            }
        }
        .onAppear(perform: fetch)
        .navigationTitle(viewModel.tvShow?.name ?? "")
    }

}

extension TVShowDetailsView {

    private func fetch() {
        viewModel.fetch()
    }

}
