//
//  TVShowsList.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowsList: View {

    var tvShows: [TVShowListItem]
    var tvShowDidAppear: (TVShowListItem.ID) -> Void

    var body: some View {
        List {
            TVShowRows(tvShows: tvShows, tvShowDidAppear: tvShowDidAppear)
        }
        .overlay(Group {
            if tvShows.isEmpty {
                ProgressView("Hang in there...")
            }
        })
    }

}

struct TVShowsList_Previews: PreviewProvider {

    static var previews: some View {
        TVShowsList(tvShows: [], tvShowDidAppear: { _ in })
    }

}
