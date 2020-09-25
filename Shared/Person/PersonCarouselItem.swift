//
//  PersonCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import SwiftUI

struct PersonCarouselItem: View {

    var person: Person?
    var displaySize: PersonImage.DisplaySize = .medium

    @State private var isDetailActive = false

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    private var size: CGSize {
        #if os(iOS)
        return displaySize.size(forSizeClass: horizontalSizeClass)
        #else
        return displaySize.size
        #endif
    }

    var body: some View {
        VStack(alignment: .center) {
            if let person = person {
                NavigationLink(destination: PersonDetailsView(id: person.id), isActive: $isDetailActive) {
                  EmptyView()
                }
                .frame(width: 0, height: 0)
            }

            PersonImage(imageMetadata: person?.profileImage, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text(person?.name ?? ""))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Text(person?.name ?? "              \n        ")
                .fontWeight(displaySize == .large ? .heavy : .bold)
                .fixedSize(horizontal: false, vertical: true)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .accessibility(label: Text(person?.name ?? ""))
                .frame(width: size.width, alignment: .center)

            Spacer()
        }
    }

}

//struct PersonCarouselItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let person = Person(id: 1, name: "Adam Young", profileURL: URL(string: "https://pbs.twimg.com/profile_images/1275513868664659968/rVhFV8C1_400x400.jpg")!)
//        return PersonCarouselItem(person: person)
//    }
//
//}
