//
//  MovieWidgetView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI

struct MovieWidgetView: View {

    var type: MovieWidgetType
    var title: String?
    var backdropData: Data?
    var backdropImageName: String?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    Image("Popcorn")
                        .resizable()
                        .frame(width: 50, height: 50)
                }

                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(type.headerText)
                            .foregroundColor(Color(UIColor.lightGray))
                            .font(.caption)
                            .fontWeight(.heavy)
                            .shadow(color: .black, radius: 10)

                        Text("\(title ?? " ")")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.heavy)
                            .shadow(color: .black, radius: 10)
                    }
                    Spacer()
                }
                .padding()
                .frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(ZStack {
                if let backdropImageName = backdropImageName {
                    Image(backdropImageName)
                        .resizable()
                        .scaledToFill()
                }

                if let backdropData = backdropData, let uiImage = UIImage(data: backdropData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                }
            })
        }
    }

}

extension MovieWidgetView {

    enum MovieWidgetType {
        case trendingMovie
        case trendingTVShow

        var headerText: String {
            switch self {
            case .trendingMovie:
                return "Trending Movie"

            case .trendingTVShow:
                return "Trending TV Show"
            }
        }
    }

}
