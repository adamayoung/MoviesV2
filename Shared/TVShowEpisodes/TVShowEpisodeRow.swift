//
//  TVShowEpisodeRow.swift
//  Movies
//
//  Created by Adam Young on 11/09/2020.
//

import SwiftUI
import UIKit

struct TVShowEpisodeRow: View {

    var episode: TVShowEpisode

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            content
        } else {
            largeContent
        }
        #elseif os(watchOS)
        content
        #else
        largeContent
        #endif
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            StillImage(imageMetadata: episode.stillImage)
                .shadow(radius: 8)

            VStack(alignment: .leading, spacing: 5) {
                Text("Episode \(episode.episodeNumber)")
                    .font(.caption)
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)

                Text("\"\(episode.name)\"")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                if let airDate = episode.airDate {
                    Text("\(airDate, formatter: DateFormatter.longDate)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let overview = episode.overview, !overview.isEmpty {
                    Text(overview)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.vertical, 5)
    }

    private var largeContent: some View {
        HStack(alignment: .top, spacing: 20) {
            StillImage(imageMetadata: episode.stillImage, displaySize: .small)
                .shadow(radius: 8)

            VStack(alignment: .leading, spacing: 5) {
                Text("Episode \(episode.episodeNumber)")
                    .font(.caption)
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)

                Text("\"\(episode.name)\"")
                    .font(.headline)

                if let airDate = episode.airDate {
                    Text("\(airDate, formatter: DateFormatter.longDate)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let overview = episode.overview, !overview.isEmpty {
                    Text(overview)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

//struct TVShowEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowEpisodeRow()
//    }
//}
