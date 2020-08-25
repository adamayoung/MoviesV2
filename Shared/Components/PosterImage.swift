//
//  PosterImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PosterImage: View {

    var url: URL?
    var displaySize: DisplaySize = .medium

    var body: some View {
        TMDbImage(url: url)
            .aspectRatio(displaySize.size, contentMode: .fit)
            .frame(width: displaySize.size.width, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: displaySize.size.height / 50))
    }

}

extension PosterImage {

    enum DisplaySize: CGFloat {
        // swiftlint:disable duplicate_enum_cases
        #if os(watchOS)
        case small = 40
        case medium = 60
        case large = 110
        case extraLarge = 150
        #else
        case small = 60
        case medium = 90
        case large = 170
        case extraLarge = 250
        #endif
        // swiftlint:enable duplicate_enum_cases

        private static let aspectRatio: CGFloat = 100 / 150

        var size: CGSize {
            CGSize(width: (rawValue * Self.aspectRatio), height: rawValue)
        }
    }

}

struct PosterImage_Previews: PreviewProvider {

    private static let url = URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")

    static var previews: some View {
        VStack {
            PosterImage(url: url, displaySize: .small)
            PosterImage(url: url, displaySize: .medium)
            PosterImage(url: url, displaySize: .large)
            PosterImage(url: nil, displaySize: .large)
        }
    }

}
