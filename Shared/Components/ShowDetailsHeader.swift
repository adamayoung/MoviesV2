//
//  ShowDetailsHeader.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct ShowDetailsHeader: View {

    var title: String
    var subtitle: String?
    var posterURL: URL?
    var backdropURL: URL?

    private var topPadding: CGFloat {
        #if os(watchOS)
        return 10
        #else
        return 20
        #endif
    }

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                backdrop

                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        PosterImage(url: posterURL, displaySize: .extraLarge)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)

                        Group {
                            #if os(watchOS)
                            Text(title)
                                .font(.headline)
                                .fontWeight(.heavy)
                            #else
                            Text(title)
                                .font(.title)
                                .fontWeight(.heavy)
                            #endif
                        }
                        .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 10)
                .padding(.top, topPadding)
            }

            if let subtitle = subtitle {
                HStack(alignment: .center) {
                    Text(subtitle)
                        .italic()
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)

                    //.fixedSize(horizontal: false, vertical: true)
            }
        }
        .foregroundColor(.primary)
        .textCase(.none)
    }

    private var backdrop: some View {
        Color.gray
            .overlay(
                WebImage(url: backdropURL)
            )
            .frame(height: PosterImage.DisplaySize.extraLarge.size.height * 1.4)
            .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.clear]), startPoint: .top, endPoint: .bottom))
            .clipped()

    }

}

extension ShowDetailsHeader {

    init(movie: Movie) {
        self.init(title: movie.title, subtitle: movie.tagline, posterURL: movie.posterURL,
                  backdropURL: movie.backdropURL)
    }

    init(tvShow: TVShow) {
        self.init(title: tvShow.name, posterURL: tvShow.posterURL, backdropURL: tvShow.backdropURL)
    }

}

struct ShowDetailsHeader_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            List {
                ShowDetailsHeader(title: "The Old Guard", posterURL: URL(string: "https://image.tmdb.org/t/p/w500/cjr4NWURcVN3gW5FlHeabgBHLrY.jpg"), backdropURL: URL(string: "https://image.tmdb.org/t/p/w780/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))
            }
        }
    }

}
