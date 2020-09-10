//
//  MoviesCarousel.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct MoviesCarousel: View {

    var movies: [Movie]
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !movies.isEmpty {
                    ForEach(movies) { movie in
                        MovieCarouselItem(movie: movie, displaySize: displaySize)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        MovieCarouselItem(displaySize: displaySize)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .animation(.default)
        .disabled(movies.isEmpty)
    }

}

struct MoviesCarousel_Previews: PreviewProvider {

    static var previews: some View {
        MoviesCarousel(movies: [])
    }

}
