//
//  MovieCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct MovieCarouselItem: View {

    @State private var isDetailActive = false

    var movie: MovieListItem?
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        VStack(alignment: .leading) {
            if let movie = movie {
                NavigationLink(destination: MovieDetailsView(id: movie.id), isActive: $isDetailActive) {
                  EmptyView()
                }
                .frame(width: 0, height: 0)
            }

            BackdropImage(path: movie?.backdropPath, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text("Backdrop Image - \(movie?.title ?? "")"))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Text(movie?.title ?? " ")
                .font(displaySize == .large ? .headline : .subheadline)
                .fontWeight(displaySize == .large ? .heavy : .bold)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .accessibility(label: Text(movie?.title ?? " "))
                .frame(width: displaySize.size.width, alignment: .leading)
            Spacer()
        }
    }

}

struct MovieCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        let movie = MovieListItem(id: 1, title: "The Old Guard",
                                  backdropPath: URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))

        return MovieCarouselItem(movie: movie)
    }

}
