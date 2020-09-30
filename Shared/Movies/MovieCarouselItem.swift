//
//  MovieCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct MovieCarouselItem: View {

    var movie: Movie?
    var imageType: ImageType

    @State private var isDetailActive = false

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    private var size: CGSize {
        switch imageType {
        case .backdrop(let displaySize):
            #if os(iOS)
            return displaySize.size(forSizeClass: horizontalSizeClass)
            #else
            return displaySize.size
            #endif

        case .poster(let displaySize):
            #if os(iOS)
            return displaySize.size(forSizeClass: horizontalSizeClass)
            #else
            return displaySize.size
            #endif
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let movie = movie {
                NavigationLink(destination: MovieDetailsView(id: movie.id), isActive: $isDetailActive) {
                    EmptyView()
                }
                .frame(width: 0, height: 0)
            }

            Group {
                switch imageType {
                case .backdrop(let displaySize):
                    BackdropImage(imageMetadata: movie?.backdropImage, displaySize: displaySize)
                        .accessibility(label: Text("\(movie?.title ?? "")"))
                        .accessibility(identifier: "\(movie?.id ?? -1)")

                case .poster(let displaySize):
                    PosterImage(imageMetadata: movie?.posterImage, displaySize: displaySize)
                        .accessibility(label: Text("\(movie?.title ?? "")"))
                        .accessibility(identifier: "\(movie?.id ?? -1)")
                }
            }
            .shadow(radius: 8)
            .onTapGesture {
                self.isDetailActive = true
            }

            Text(movie?.title ?? "              \n        ")
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .accessibility(label: Text(movie?.title ?? " "))
                .frame(width: size.width, alignment: .leading)
            Spacer()
        }
    }

}

extension MovieCarouselItem {

    enum ImageType {
        case poster(displaySize: PosterImage.DisplaySize = .medium)
        case backdrop(displaySize: BackdropImage.DisplaySize = .medium)
    }

}

//struct MovieCarouselItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let movie = Movie(id: 1, title: "The Old Guard",
//                          backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))
//
//        return MovieCarouselItem(movie: movie)
//    }
//
//}
