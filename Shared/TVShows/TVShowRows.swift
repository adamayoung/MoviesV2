//
//  TVShowRows.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct TVShowRows: View {

    var tvShows: [TVShowListItem]
    var tvShowDidAppear: ((TVShowListItem.ID) -> Void)?

    var body: some View {
        ForEach(tvShows) { tvShow in
            NavigationLink(destination: TVShowDetailsView(id: tvShow.id)) {
                TVShowRow(tvShow: tvShow)
                    .onAppear {
                        self.tvShowDidAppear?(tvShow.id)
                    }
            }
        }
    }

}

struct TVShowRows_Previews: PreviewProvider {

    static var previews: some View {
        TVShowRows(tvShows: [])
    }

}
