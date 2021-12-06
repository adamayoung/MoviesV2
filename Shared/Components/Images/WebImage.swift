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

    @StateObject private var image = FetchImage()

    var body: some View {
        ZStack {
            image.view?
                .resizable()
                .scaledToFill()
                .clipped()
        }
        .onAppear(perform: load)
        .onDisappear(perform: image.reset)
        .animation(.default, value: image.view)
    }

    private func load() {
        guard let url = url else {
            return
        }

        withoutAnimation {
            image.load(url)
        }
    }

    private func withoutAnimation(_ closure: () -> Void) {
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction, closure)
    }

}

struct WebImage_Previews: PreviewProvider {

    static var previews: some View {
        WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/A3z0KMLIEGL22mVrgaV7KDxKRmT.jpg")!)
    }

}
