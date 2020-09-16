//
//  MovieCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct MovieCarouselItem: View {

    var movie: Movie?
    var displaySize: BackdropImage.DisplaySize = .medium

    @State private var isDetailActive = false

    private var titleFont: Font {
        switch displaySize {
        case .extraLarge:
            return Font.title.weight(.heavy)

        case .large:
            return Font.headline.weight(.heavy)

        case .medium:
            return Font.subheadline.weight(.bold)

        case .small:
            return Font.body.weight(.bold)
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

            BackdropImage(url: movie?.backdropURL, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text("Backdrop Image - \(movie?.title ?? "")"))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Text(movie?.title ?? "              \n        ")
                .font(titleFont)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .accessibility(label: Text(movie?.title ?? " "))
                .frame(width: displaySize.size.width, alignment: .leading)
            Spacer()
        }
    }

}

struct MovieCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        let movie = Movie(id: 1, title: "The Old Guard",
                          backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))

        return MovieCarouselItem(movie: movie)
    }

}
