//
//  ShowsCarousel.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct ShowsCarousel: View {

    var shows: [Show]
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !shows.isEmpty {
                    ForEach(shows) { show in
                        ShowCarouselItem(show: show, displaySize: displaySize)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        ShowCarouselItem(displaySize: displaySize)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .animation(.default)
        .disabled(shows.isEmpty)
    }

}

struct ShowsCarousel_Previews: PreviewProvider {

    static var previews: some View {
        ShowsCarousel(shows: [])
    }

}
