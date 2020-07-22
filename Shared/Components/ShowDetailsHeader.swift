//
//  ShowDetailsHeader.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct ShowDetailsHeader: View {

    #if os(watchOS)
    private let topPadding: CGFloat = 10
    #else
    private let topPadding: CGFloat = 20
    #endif

    var title: String
    var subtitle: String?
    var posterPath: URL?
    var backdropPath: URL?

    init(title: String, subtitle: String? = nil, posterPath: URL? = nil, backdropPath: URL? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                backdrop

                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        PosterImage(path: posterPath, displaySize: .extraLarge)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)

                        #if os(watchOS)
                        Text(title)
                            .font(.headline)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                        #else
                        Text(title)
                            .font(.title)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                        #endif

                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.body)
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.top)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, topPadding)
            }
        }
        .textCase(.none)
        .foregroundColor(.primary)
    }

    private var backdrop: some View {
        Color.gray
            .overlay(
                TMDbImage(path: backdropPath)
            )
            .frame(height: PosterImage.DisplaySize.extraLarge.size.height * 1.4)
            .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.clear]), startPoint: .top, endPoint: .bottom))
            .clipped()

    }

}

extension ShowDetailsHeader {

    init(movie: Movie) {
        self.init(title: movie.title, subtitle: movie.tagline, posterPath: movie.posterPath,
                  backdropPath: movie.backdropPath)
    }

    init(tvShow: TVShow) {
        self.init(title: tvShow.name, posterPath: tvShow.posterPath, backdropPath: tvShow.backdropPath)
    }

}

struct ShowDetailsHeader_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            List {
                ShowDetailsHeader(title: "The Old Guard", posterPath: URL(string: "https://image.tmdb.org/t/p/w500/cjr4NWURcVN3gW5FlHeabgBHLrY.jpg"), backdropPath: URL(string: "https://image.tmdb.org/t/p/w780/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))
            }
        }
    }

}
