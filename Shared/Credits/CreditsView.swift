//
//  CreditsView.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct CreditsView: View {

    @ObservedObject var viewModel: CreditsViewModel

    init(viewModel: CreditsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        #if os(watchOS)
        content
        #else
        content
            .navigationBarTitleDisplayMode(.large)
        #endif
    }

    var content: some View {
        Group {
            if let credits = viewModel.credits {
                CreditsList(credits: credits)
                    .listStyle(DefaultListStyle())
            } else {
                ProgressView("Hang in there...")
            }
        }
        .onAppear(perform: fetch)
        .navigationTitle("Cast & Crew")
    }

}

extension CreditsView {

    init(movieID: Movie.ID) {
        self.init(viewModel: CreditsViewModel(movieID: movieID))
    }

    init(tvShowID: TVShow.ID) {
        self.init(viewModel: CreditsViewModel(tvShowID: tvShowID))
    }

}

extension CreditsView {

    private func fetch() {
        viewModel.fetch()
    }

}

struct CreditsView_Previews: PreviewProvider {

    static var previews: some View {
        CreditsView(movieID: 1)
    }

}
