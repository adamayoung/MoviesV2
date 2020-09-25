//
//  CastMemberCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct CastMemberCarouselItem: View {

    var castMember: CastMember?
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
            if let castMember = castMember {
                NavigationLink(destination: PersonDetailsView(id: castMember.id), isActive: $isDetailActive) {
                  EmptyView()
                }
                .frame(width: 0, height: 0)
            }

            PersonImage(imageMetadata: castMember?.profileImage, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text(castMember?.name ?? ""))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Group {
                Text(castMember?.name ?? "              \n        ")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: Text(castMember?.name ?? ""))

                Text(castMember?.character ?? "              \n        ")
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: Text(castMember?.character ?? ""))
            }
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .frame(width: size.width, alignment: .center)

            Spacer()
        }
    }

}

struct CastMemberCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        let castMember = CastMember(id: 1, creditID: "a", name: "Adam Young", character: "Software Engineer", order: 1)
        return CastMemberCarouselItem(castMember: castMember)
    }

}
