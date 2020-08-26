//
//  PersonImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct PersonImage: View {

    var url: URL?
    var displaySize: DisplaySize = .medium

    var body: some View {
        ZStack(alignment: .center) {
            placeholder
            WebImage(url: url)
        }
        .frame(width: displaySize.size.width, height: displaySize.size.height, alignment: .center)
        .clipShape(Circle())
    }

    @ViewBuilder private var placeholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray, Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        Image(systemName: "person.fill")
            .resizable()
            .scaleEffect(0.6)
            .foregroundColor(Color.primary.opacity(0.25))
            .frame(width: displaySize.size.width, height: displaySize.size.height, alignment: .center)
    }

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
            PersonImage(url: url, displaySize: .small)
            PersonImage(url: url, displaySize: .medium)
            PersonImage(url: url, displaySize: .large)
            PersonImage(url: nil, displaySize: .large)
        }
    }

}
