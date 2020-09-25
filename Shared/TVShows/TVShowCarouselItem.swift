//
//  TVShowCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TVShowCarouselItem: View {

    var tvShow: TVShow?
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
            if let tvShow = tvShow {
                NavigationLink(destination: TVShowDetailsView(id: tvShow.id), isActive: self.$isDetailActive) {
                    EmptyView()
                }
            }

            Group {
                switch imageType {
                case .backdrop(let displaySize):
                    BackdropImage(imageMetadata: tvShow?.backdropImage, displaySize: displaySize)
                        .accessibility(label: Text("Backdrop Image - \(tvShow?.name ?? "")"))

                case .poster(let displaySize):
                    PosterImage(imageMetadata: tvShow?.posterImage, displaySize: displaySize)
                        .accessibility(label: Text("Poster Image - \(tvShow?.name ?? "")"))
                }
            }
            .shadow(radius: 8)
            .onTapGesture {
                self.isDetailActive = true
            }

            Text(tvShow?.name ?? "              \n        ")
                .fixedSize(horizontal: false, vertical: true)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .accessibility(label: Text(tvShow?.name ?? ""))
                .frame(width: size.width, alignment: .leading)

            Spacer()
        }
    }

}

extension TVShowCarouselItem {

    enum ImageType {
        case poster(displaySize: PosterImage.DisplaySize = .medium)
        case backdrop(displaySize: BackdropImage.DisplaySize = .medium)
    }

}

//struct TVShowCarouselItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let tvShow = TVShow(id: 1, name: "The Old Guard",
//                            backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))
//
//        return TVShowCarouselItem(tvShow: tvShow)
//    }
//
//}
