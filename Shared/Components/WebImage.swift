//
//  TMDbImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import FetchImage
import SwiftUI

struct WebImage: View {

    var url: URL?

    var body: some View {
        Group {
            if let url = url {
                InternalWebImage(url: url)
            }
        }
        .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
    }

}

private struct InternalWebImage: View {

    @ObservedObject var image: FetchImage

    init(url: URL) {
        image = FetchImage(url: url)
    }

    var body: some View {
        Group {
            image.view?
                .resizable()
                .scaledToFill()
        }
    }

}

struct WebImage_Previews: PreviewProvider {

    static var previews: some View {
        WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/A3z0KMLIEGL22mVrgaV7KDxKRmT.jpg")!)
    }

}
