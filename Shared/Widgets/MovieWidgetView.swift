//
//  MovieWidgetView.swift
//  Movies
//
//  Created by Adam Young on 16/07/2020.
//

import SwiftUI
import WidgetKit

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
                        .shadow(color: .black, radius: 2)
                }

                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(type.headerText)
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .shadow(color: .black, radius: 10)

                        if title != nil {
                            titleContent
                        } else {
                            titleContent
                                .redacted(reason: .placeholder)
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(ZStack {
                backgroundPlaceholder

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

    private var titleContent: some View {
        Text("\(title ?? "               ")")
            .foregroundColor(.white)
            .font(.title)
            .fontWeight(.heavy)
            .shadow(color: .black, radius: 10)
    }

    private var backgroundPlaceholder: some View {
        LinearGradient(gradient: Gradient(colors: [Color(.darkGray), Color(white: 0.4, opacity: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
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

struct MovieWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieWidgetView(type: .trendingMovie, title: "The Old Guard", backdropImageName: "TrendingMoviePlaceholderBackdrop")
                .previewContext(WidgetPreviewContext(family: .systemLarge))

            MovieWidgetView(type: .trendingTVShow, title: "Game of Thrones", backdropImageName: "TrendingTVShowPlaceholderBackdrop")
                .previewContext(WidgetPreviewContext(family: .systemLarge))

            MovieWidgetView(type: .trendingMovie, title: nil)
                .previewContext(WidgetPreviewContext(family: .systemLarge))

            MovieWidgetView(type: .trendingMovie, title: "The Old Guard", backdropImageName: "TrendingMoviePlaceholderBackdrop")
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            MovieWidgetView(type: .trendingTVShow, title: "Game of Thrones", backdropImageName: "TrendingTVShowPlaceholderBackdrop")
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            MovieWidgetView(type: .trendingTVShow, title: nil)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
