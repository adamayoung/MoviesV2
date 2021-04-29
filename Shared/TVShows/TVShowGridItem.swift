//
//  TVShowGridItem.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct TVShowGridItem: View {

    var tvShow: TVShow
    var showFooter = false

    var body: some View {
        VStack {
            PosterImage(imageMetadata: tvShow.posterImage)
                .shadow(radius: 5)

            if showFooter {
                Group {
                    Text("TV Show")

                    if let firstAirDate = tvShow.firstAirDate {
                        Text("\(firstAirDate, formatter: DateFormatter.year)")
                    }
                }
                .foregroundColor(.secondary)
            }

            Spacer()
        }
    }

}

// struct TVShowGridItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TVShowGridItem()
//    }
//
// }
