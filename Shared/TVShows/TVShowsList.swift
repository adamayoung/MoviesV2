//
//  TVShowsList.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct TVShowsList: View {

    var tvShows: [TVShowListItem] = []
    var tvShowDidAppear: ((TVShowListItem) -> Void)?

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #elseif os(iOS)
        content
            .listStyle(GroupedListStyle())
        #else
        content
        #endif
    }

    var content: some View {
        List(tvShows) { tvShow in
            NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                TVShowRow(tvShow: tvShow)
                    .onAppear {
                        self.tvShowDidAppear?(tvShow)
                    }
            }
        }
        .overlay(Group {
            if tvShows.isEmpty {
                ProgressView()
            }
        })
    }

}

struct TVShowsList_Previews: PreviewProvider {

    static var previews: some View {
        TVShowsList()
    }

}
