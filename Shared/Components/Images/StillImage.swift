//
//  StillImage.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import SwiftUI

struct StillImage: View {

    var imageMetadata: StillImageMetadata?
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
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }

    private var content: some View {
        ZStack(alignment: .center) {
            placeholder
            WebImage(url: imageMetadata?.originalURL, lowDataURL: imageMetadata?.lowDataURL)
        }
        .aspectRatio(DisplaySize.aspectRatio, contentMode: .fit)
    }

    private var placeholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray, Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}

extension StillImage {

    enum DisplaySize: CGFloat {

        case small = 150
        case medium = 200
        case large = 300

        static var aspectRatio: CGFloat {
            CGFloat(StillImageMetadata.aspectRatio)
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

// struct StillImage_Previews: PreviewProvider {

//    private static let url = URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg")

//    static var previews: some View {
//        VStack {
//            StillImage(url: url, displaySize: .small)
//            StillImage(url: url, displaySize: .medium)
//            StillImage(url: url, displaySize: .large)
//            StillImage(url: nil, displaySize: .large)
//        }
//    }

// }
