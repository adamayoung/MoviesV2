//
//  PersonCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonCarouselItem: View {

    @State private var isDetailActive = false

    var person: Person?
    var displaySize: PersonImage.DisplaySize = .medium

    var body: some View {
        VStack(alignment: .center) {
            if let person = person {
                NavigationLink(destination: PersonDetailsView(id: person.id), isActive: $isDetailActive) {
                  EmptyView()
                }
                .frame(width: 0, height: 0)
            }

            PersonImage(url: person?.profileURL, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text(person?.name ?? ""))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Text(person?.name ?? " \n ")
                .fontWeight(displaySize == .large ? .heavy : .bold)
                .fixedSize(horizontal: false, vertical: true)
                .font(displaySize == .large ? .headline : .subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .accessibility(label: Text(person?.name ?? ""))
                .frame(width: displaySize.size.width * 1.25, alignment: .center)

            Spacer()
        }
    }

}

struct PersonCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        let person = Person(id: 1, name: "Adam Young", profileURL: URL(string: "https://pbs.twimg.com/profile_images/1275513868664659968/rVhFV8C1_400x400.jpg")!)
        return PersonCarouselItem(person: person)
    }

}
