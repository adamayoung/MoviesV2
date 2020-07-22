//
//  PosterImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PosterImage: View {

    var path: URL?
    var displaySize: DisplaySize

    init(path: URL? = nil, displaySize: DisplaySize = .medium) {
        self.path = path
        self.displaySize = displaySize
    }

    var body: some View {
        TMDbImage(path: path)
            .frame(width: displaySize.size.width, height: displaySize.size.height)
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
        case large = 200
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
            PosterImage(path: url, displaySize: .small)
            PosterImage(path: url, displaySize: .medium)
            PosterImage(path: url, displaySize: .large)
            PosterImage(path: nil, displaySize: .large)
        }
    }

}
