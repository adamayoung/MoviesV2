//
//  BackdropImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct BackdropImage: View {

    var path: URL?
    var displaySize: DisplaySize

    init(path: URL? = nil, displaySize: DisplaySize = .medium) {
        self.path = path
        self.displaySize = displaySize
    }

    var body: some View {
        TMDbImage(path: path)
            .frame(width: displaySize.size.width, height: displaySize.size.height)
            .cornerRadius(displaySize.size.height / 10)
    }

}

extension BackdropImage {

    enum DisplaySize: CGFloat {
        case small = 60
        case medium = 100
        case large = 150

        private static let aspectRatio: CGFloat = 500 / 281

        var size: CGSize {
            CGSize(width: (rawValue * Self.aspectRatio), height: rawValue)
        }
    }

}

struct BackdropImage_Previews: PreviewProvider {

    private static let url = URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg")

    static var previews: some View {
        VStack {
            BackdropImage(path: url, displaySize: .small)
            BackdropImage(path: url, displaySize: .medium)
            BackdropImage(path: url, displaySize: .large)
            BackdropImage(path: nil, displaySize: .large)
        }
    }

}
