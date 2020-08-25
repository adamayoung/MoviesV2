//
//  TVShowCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TVShowCarouselItem: View {

    @State private var isDetailActive = false

    var tvShow: TVShowListItem?
    var displaySize: BackdropImage.DisplaySize = .medium

    var body: some View {
        VStack(alignment: .leading) {
            if let tvShow = tvShow {
                NavigationLink(destination: TVShowDetailsView(id: tvShow.id), isActive: self.$isDetailActive) {
                  EmptyView()
                }
            }

            BackdropImage(url: tvShow?.backdropURL, displaySize: displaySize)
                .shadow(radius: 8)
                .accessibility(label: Text("Backdrop Image - \(tvShow?.name ?? "")"))
                .onTapGesture {
                    self.isDetailActive = true
                }

            Text(tvShow?.name ?? "              ")
                .font(displaySize == .large ? .headline : .subheadline)
                .fontWeight(displaySize == .large ? .heavy : .bold)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .accessibility(label: Text(tvShow?.name ?? ""))
                .frame(width: displaySize.size.width, alignment: .leading)
            Spacer()
        }
    }

}

struct TVShowCarouselItem_Previews: PreviewProvider {

    static var previews: some View {
        let tvShow = TVShowListItem(id: 1, name: "The Old Guard",
                                    backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))

        return TVShowCarouselItem(tvShow: tvShow)
    }

}
