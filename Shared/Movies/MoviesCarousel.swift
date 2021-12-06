//
//  MoviesCarousel.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct MoviesCarousel: View {

    var movies: [Movie]
    var imageType: MovieCarouselItem.ImageType = .backdrop(displaySize: .medium)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !movies.isEmpty {
                    ForEach(movies) { movie in
                        MovieCarouselItem(movie: movie, imageType: imageType)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        MovieCarouselItem(imageType: imageType)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .animation(.default, value: movies)
        .disabled(movies.isEmpty)
    }

}

struct MoviesCarousel_Previews: PreviewProvider {

    static var previews: some View {
        MoviesCarousel(movies: [])
    }

}
