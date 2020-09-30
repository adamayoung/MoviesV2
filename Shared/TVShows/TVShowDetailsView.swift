//
//  TVShowDetailsView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowDetailsView: View {

    var id: TVShow.ID

    @EnvironmentObject private var tvShowStore: TVShowStore
    @EnvironmentObject private var cloudKitAvailability: CloudKitAvailability

    private var tvShow: TVShow? {
        tvShowStore.tvShow(withID: id)
    }

    private var isFavourite: Bool {
        guard let tvShow = tvShow else {
            return false
        }

        return tvShowStore.isFavourite(tvShowID: tvShow.id)
    }

    private var seasons: [TVShowSeason]? {
        tvShowStore.seasons(forTVShow: id)
    }

    private var credits: Credits? {
        tvShowStore.credits(forTVShow: id)
    }

    private var recommendations: [TVShow]? {
        tvShowStore.recommendations(forTVShow: id)
    }

    private var title: String {
        tvShow?.name ?? ""
    }

    var body: some View {
        container
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if tvShow != nil {
                        Button(action: {
                            toogleFavourite()
                        }, label: {
                            favouriteButtonLabel
                        })
                        .disabled(!cloudKitAvailability.isAvailable)
                    }
                }
            }
            .onAppear(perform: fetch)
            .navigationTitle(title)
    }

    @ViewBuilder private var container: some View {
        #if os(iOS)
        content
            .navigationBarTitleDisplayMode(.inline)
        #elseif os(macOS)
        content
            .frame(minWidth: 500, idealWidth: 700, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        #else
        content
        #endif
    }

    @ViewBuilder private var content: some View {
        if let tvShow = self.tvShow,
           let seasons = self.seasons,
           let credits = self.credits,
           let recommendations = self.recommendations {
            TVShowDetails(tvShow: tvShow, seasons: seasons, credits: credits, recommendations: recommendations)
                .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
                .accessibility(identifier: "TVShowDetails")
        } else {
            ProgressView()
        }
    }

    private var favouriteButtonLabel: some View {
        let imageName = isFavourite ? "heart.fill" : "heart"

        #if !os(watchOS)
        return Image(systemName: imageName)
        #else
        let title = isFavourite ? "Remove Favourite" : "Add Favourite"
        return Label(title, systemImage: imageName)
        #endif
    }

    private func toogleFavourite() {
        guard cloudKitAvailability.isAvailable else {
            return
        }

        guard let tvShow = tvShow else {
            return
        }

        tvShowStore.toggleFavourite(tvShow: tvShow)
    }

}

extension TVShowDetailsView {

    private func fetch() {
        tvShowStore.fetchTVShow(withID: id)
        tvShowStore.fetchCredits(forTVShow: id)
        tvShowStore.fetchRecommendations(forTVShow: id)
    }

}

struct TVShowDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        TVShowDetailsView(id: 1)
    }

}
