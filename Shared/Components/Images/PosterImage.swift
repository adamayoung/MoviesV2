//
//  PosterImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PosterImage: View {

    var imageMetadata: PosterImageMetadata?
    var displaySize: DisplaySize?

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    private var size: CGSize? {
        #if os(iOS)
        return displaySize?.size(forSizeClass: horizontalSizeClass)
        #else
        return displaySize?.size
        #endif
    }

    var body: some View {
        Group {
            if let size = size {
                content
                    .frame(width: size.width, alignment: .center)
            } else {
                content
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var content: some View {
        ZStack(alignment: .center) {
            placeholder
            WebImage(url: imageMetadata?.url)
        }
        .aspectRatio(DisplaySize.aspectRatio, contentMode: .fit)
    }

    private var placeholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray, Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}

extension PosterImage {

    enum DisplaySize: CGFloat {

        case small = 150
        case medium = 200
        case large = 300

        static var aspectRatio: CGFloat {
            CGFloat(PosterImageMetadata.aspectRatio)
        }

        #if os(iOS)
        func size(forSizeClass horizontalSizeClass: UserInterfaceSizeClass?) -> CGSize {
            let height = horizontalSizeClass == .regular ? rawValue * 1.5 : rawValue

            return CGSize(width: (height * Self.aspectRatio), height: height)
        }
        #elseif os(watchOS)
        var size: CGSize {
            let height = rawValue * 0.5

            return CGSize(width: (height * Self.aspectRatio), height: height)
        }
        #else
        var size: CGSize {
            CGSize(width: (rawValue * Self.aspectRatio), height: rawValue)
        }
        #endif

    }

}

// struct PosterImage_Previews: PreviewProvider {

//    private static let url = URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")

//    static var previews: some View {
//        VStack {
//            PosterImage(url: url, displaySize: .small)
//            PosterImage(url: url, displaySize: .medium)
//            PosterImage(url: url, displaySize: .large)
//            PosterImage(url: nil, displaySize: .large)
//        }
//    }

// }
