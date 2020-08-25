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

                Group {
                    if title != nil {
                        content
                    } else {
                        content
                            .redacted(reason: .placeholder)
                    }
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

                if let backdropData = backdropData {
                    #if os(iOS)
                    if let uiImage = UIImage(data: backdropData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    }
                    #endif

                    #if os(macOS)
                    if let nsImage = NSImage(data: backdropData) {
                        Image(nsImage: nsImage)
                            .resizable()
                            .scaledToFill()
                    }
                    #endif
                }
            })
        }
    }

    private var content: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(type.headerText)
                    .foregroundColor(.white)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .shadow(color: .black, radius: 10)

                Text("\(title ?? "               ")")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.heavy)
                    .shadow(color: .black, radius: 10)
            }
            Spacer()
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
