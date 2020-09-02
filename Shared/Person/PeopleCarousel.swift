//
//  PeopleCarousel.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PeopleCarousel: View {

    var people: [PersonListItem]
    var displaySize: PersonImage.DisplaySize = .medium

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if !people.isEmpty {
                    ForEach(people) { person in
                        PersonCarouselItem(person: person, displaySize: displaySize)
                    }
                } else {
                    ForEach(0...10, id: \.self) { _ in
                        PersonCarouselItem(displaySize: displaySize)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
        .animation(.default)
        .disabled(people.isEmpty)
    }

}

struct PeopleCarousel_Previews: PreviewProvider {

    static var previews: some View {
        PeopleCarousel(people: [])
    }

}
