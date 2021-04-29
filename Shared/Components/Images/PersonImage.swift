//
//  PersonImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PersonImage: View {

    var imageMetadata: ProfileImageMetadata?
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
                    .frame(width: size.width, height: size.height, alignment: .center)
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

    @ViewBuilder private var placeholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray, Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        Image(systemName: "person.fill")
            .resizable()
            .scaleEffect(0.6)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(Color.primary.opacity(0.25))
            .opacity(imageMetadata == nil ? 1 : 0)
    }

}

extension PersonImage {

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

// struct PersonImage_Previews: PreviewProvider {

//    private static let url = URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")

//    static var previews: some View {
//        VStack {
//            PersonImage(url: url, displaySize: .small)
//            PersonImage(url: url, displaySize: .medium)
//            PersonImage(url: url, displaySize: .large)
//            PersonImage(url: nil, displaySize: .large)
//        }
//    }

// }
