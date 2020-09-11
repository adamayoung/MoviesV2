//
//  BackdropImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct BackdropImage: View {

    var url: URL?
    var displaySize: DisplaySize?

    var body: some View {
        Group {
            if let displaySize = displaySize {
                content
                    .frame(width: displaySize.size.width, alignment: .center)
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

    private var placeholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray, Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}

extension BackdropImage {

    enum DisplaySize: CGFloat {
        case small = 60
        case medium = 100
        case large = 150
        case extraLarge = 250

        static let aspectRatio: CGFloat = 500 / 281

        var size: CGSize {
            CGSize(width: (rawValue * Self.aspectRatio), height: rawValue)
        }
    }

}

struct BackdropImage_Previews: PreviewProvider {

    private static let url = URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg")

    static var previews: some View {
        VStack {
            BackdropImage(url: url, displaySize: .small)
            BackdropImage(url: url, displaySize: .medium)
            BackdropImage(url: url, displaySize: .large)
            BackdropImage(url: nil, displaySize: .large)
        }
    }

}
