//
//  MovieGridItem.swift
//  Movies
//
//  Created by Adam Young on 30/08/2020.
//

import SwiftUI

struct MovieGridItem: View {

    var movie: Movie
    var showFooter = false

    var body: some View {
        VStack {
            PosterImage(imageMetadata: movie.posterImage)
                .shadow(radius: 5)

            if showFooter, let releaseDate = movie.releaseDate {
                Text("\(releaseDate, formatter: DateFormatter.year)")
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }

}

//struct MovieGridItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieGridItem()
//    }
//}
