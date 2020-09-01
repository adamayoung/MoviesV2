//
//  CastCarousel.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct CastCarousel: View {

    var cast: [CastMember]
    var displaySize: PersonImage.DisplaySize = .medium

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !cast.isEmpty {
                    ForEach(cast) { castMember in
                        CastMemberCarouselItem(castMember: castMember, displaySize: displaySize)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        CastMemberCarouselItem(displaySize: displaySize)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .disabled(cast.isEmpty)
    }

}

struct CastCarousel_Previews: PreviewProvider {

    static var previews: some View {
        CastCarousel(cast: [])
    }

}
