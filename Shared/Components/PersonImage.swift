//
//  PersonImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PersonImage: View {

    var path: URL?
    var displaySize: DisplaySize

    init(path: URL? = nil, displaySize: DisplaySize = .medium) {
        self.path = path
        self.displaySize = displaySize
    }

    var body: some View {
        TMDbImage(path: path)
            .frame(width: displaySize.size.width, height: displaySize.size.height)
            .clipShape(Circle())
    }

//    private var placeholder: some View {
//        Image(systemName: "person.fill")
//            .resizable()
//            .padding(.horizontal, displaySize.size.width / 4)
//            .padding(.vertical, displaySize.size.height / 4)
//            .foregroundColor(.secondary)
//    }

}

extension PersonImage {

    enum DisplaySize: CGFloat {
        // swiftlint:disable duplicate_enum_cases
        #if !os(watchOS)
        case small = 60
        case medium = 90
        case large = 160
        #else
        case small = 40
        case medium = 60
        case large = 100
        #endif
        // swiftlint:enable duplicate_enum_cases

        var size: CGSize {
            CGSize(width: rawValue, height: rawValue)
        }
    }

}

struct PersonImage_Previews: PreviewProvider {

    private static let url = URL(string: "https://image.tmdb.org/t/p/w780/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")

    static var previews: some View {
        VStack {
            PersonImage(path: url, displaySize: .small)
            PersonImage(path: url, displaySize: .medium)
            PersonImage(path: url, displaySize: .large)
            PersonImage(path: nil, displaySize: .large)
        }
    }

}
