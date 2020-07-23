//
//  TMDbImage.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SDWebImageSwiftUI
import SwiftUI
import TMDb

struct TMDbImage: View {

    @ObservedObject private var configurationStore: ConfigurationStore

    var path: URL?

    init(path: URL? = nil, configurationStore: ConfigurationStore = .shared) {
        self.path = path
        self.configurationStore = configurationStore
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.secondary]), startPoint: .topLeading, endPoint: .bottomTrailing)

            Group {
                if path?.scheme != nil {
                    WebImage(url: path)
                        .resizable()
                } else if let url = configurationStore.imagesConfiguration?.imageURL(fromPath: path) {
                    WebImage(url: url)
                        .resizable()
                }
            }
            .scaledToFill()
            .transition(AnyTransition.opacity.animation(Animation.easeOut.speed(0.5)))
        }
        .onAppear(perform: fetchConfiguration)
    }

    private func fetchConfiguration() {
        guard path != nil else {
            return
        }

        configurationStore.fetchIfNeeded()
    }

}

struct TMDbImage_Previews: PreviewProvider {

    static var previews: some View {
        TMDbImage()
    }

}
