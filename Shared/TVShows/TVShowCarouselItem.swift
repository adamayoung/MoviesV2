//
//  TVShowCarouselItem.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import SwiftUI

struct TVShowCarouselItem: View {
    
    var tvShow: TVShow?
    var displaySize: BackdropImage.DisplaySize = .medium
    
    @State private var isDetailActive = false
    
    private var titleFont: Font {
        switch displaySize {
        case .extraLarge:
            return Font.title.weight(.heavy)
            
        case .large:
            return Font.headline.weight(.heavy)
            
        case .medium:
            return Font.subheadline.weight(.bold)
            
        case .small:
            return Font.body.weight(.bold)
        }
    }
    
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
            
            Text(tvShow?.name ?? "              \n        ")
                .fixedSize(horizontal: false, vertical: true)
                .font(titleFont)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .accessibility(label: Text(tvShow?.name ?? ""))
                .frame(width: displaySize.size.width, alignment: .leading)
            
            Spacer()
        }
    }
    
}

struct TVShowCarouselItem_Previews: PreviewProvider {
    
    static var previews: some View {
        let tvShow = TVShow(id: 1, name: "The Old Guard",
                            backdropURL: URL(string: "https://image.tmdb.org/t/p/w500/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg"))
        
        return TVShowCarouselItem(tvShow: tvShow)
    }
    
}
