//
//  MoviesCarousel.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct MoviesCarousel: View {

    var header: String?
    var movies: [MovieListItem]
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header = header {
                HStack(alignment: .center) {
                    Text("\(header)")
                        .font(displaySize == .large ? .title2 : .title3)
                        .fontWeight(.heavy)

                    Spacer()
                    ScrollView {
                    NavigationLink(destination: EmptyView()) {
                        Text("See more")
                    }
                    }
                }
                .padding([.horizontal, .top])
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    if !movies.isEmpty {
                        ForEach(movies) { movie in
                            MovieCarouselItem(movie: movie, displaySize: displaySize)
                        }
                    } else {
                        ForEach(0...10, id: \.self) { _ in
                            MovieCarouselItem(displaySize: displaySize)
                        }
                    }
                }
                .padding(20)
            }
            .disabled(movies.isEmpty)
        }
    }
}

struct MoviesCarousel_Previews: PreviewProvider {

    static var previews: some View {
        MoviesCarousel(header: "Movies", movies: [])
    }

}
