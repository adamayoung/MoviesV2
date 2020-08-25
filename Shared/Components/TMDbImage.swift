//
//  TMDbImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SDWebImageSwiftUI
import SwiftUI
import TMDb
import FetchImage

struct TMDbImage: View {

    @ObservedObject var image: FetchImage

    init(url: URL? = nil) {
        if let url = url {
            image = FetchImage(url: url)
        } else {
            image = FetchImage(url: URL(string: "https://www.domain.com")!)
        }
    }

    var body: some View {
        Group {
            if let imageView = image.view {
                imageView
                    .resizable()
            } else {
                placeholder
            }
        }
        .scaledToFill()
        .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
    }

    private var placeholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray, Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}

struct TMDbImage_Previews: PreviewProvider {

    static var previews: some View {
        TMDbImage()
    }

}
