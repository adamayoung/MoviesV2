//
//  TVShowsGrid.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct TVShowsGrid: View {

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    var tvShows: [TVShow] = []
    var tvShowDidAppear: ((TVShow) -> Void)?

    private let columnsCompact: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    private let columnsRegular: [GridItem] = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    private var columns: [GridItem] {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            return columnsCompact
        } else {
            return columnsRegular
        }
        #else
        return columnsRegular
        #endif
    }

    var body: some View {
        #if os(macOS)
        content
            .frame(minWidth: 270, idealWidth: 300, maxWidth: 400, maxHeight: .infinity)
        #else
        content
        #endif
    }

    var content: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(tvShows) { tvShow in
                    NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                        TVShowGridItem(tvShow: tvShow)
                            .onAppear {
                                self.tvShowDidAppear?(tvShow)
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

}

struct TVShowsGrid_Previews: PreviewProvider {

    static var previews: some View {
        TVShowsGrid(tvShows: [])
    }

}
