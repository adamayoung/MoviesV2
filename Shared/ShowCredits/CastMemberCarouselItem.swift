//
//  CastMemberCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import SwiftUI

struct CastMemberCarouselItem: View {

    @State private var isDetailActive = false

    var castMember: CastMember?
    var displaySize: PersonImage.DisplaySize = .medium

    var body: some View {
        VStack(alignment: .center) {
            if let castMember = castMember {
                NavigationLink(destination: PersonDetailsView(id: castMember.id), isActive: $isDetailActive) {
                  EmptyView()
                }
                .frame(width: 0, height: 0)
            }

            PersonImage(url: castMember?.profileURL, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text(castMember?.name ?? ""))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Group {
                Text(castMember?.name ?? " \n ")
                    .fontWeight(displaySize == .large ? .heavy : .bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: Text(castMember?.name ?? ""))

                Text(castMember?.character ?? " \n ")
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: Text(castMember?.character ?? ""))
            }
            .font(displaySize == .large ? .headline : .subheadline)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .frame(width: displaySize.size.width * 1.25, alignment: .center)

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
