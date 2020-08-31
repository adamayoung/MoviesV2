//
//  PersonImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PersonImage: View {

    var url: URL?
    var displaySize: DisplaySize?

    var body: some View {
        Group {
            if let displaySize = displaySize {
                content
                    .frame(width: displaySize.size.width, height: displaySize.size.height, alignment: .center)
            } else {
                content
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }

    private var content: some View {
        ZStack(alignment: .center) {
            placeholder
            WebImage(url: url)
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
            .opacity(url == nil ? 1 : 0)
    }

}

extension PersonImage {

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

        static let aspectRatio: CGFloat = 100 / 150

        var size: CGSize {
            CGSize(width: (rawValue * Self.aspectRatio), height: rawValue)
        }
    }

}

struct PersonImage_Previews: PreviewProvider {

    private static let url = URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")

    static var previews: some View {
        VStack {
            PersonImage(url: url, displaySize: .small)
            PersonImage(url: url, displaySize: .medium)
            PersonImage(url: url, displaySize: .large)
            PersonImage(url: nil, displaySize: .large)
        }
    }

}
