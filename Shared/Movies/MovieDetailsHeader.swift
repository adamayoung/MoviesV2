//
//  MovieDetailsHeader.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import SwiftUI

struct MovieDetailsHeader: View {

    var movie: Movie

    private var metadataItems: [String] {
        var items = [String]()
        if let genre = movie.genres?.first {
            items.append(genre.name)
        }

        if let releaseDate = movie.releaseDate {
            items.append(DateFormatter.year.string(from: releaseDate))
        }

        if let runtime = movie.runtime {
            let time = Int(runtime)
            let hours = Int(time / 3600)
            let minutes = Int((time / 60) % 60)

            if hours == 0 {
                items.append("\(minutes) min")
            } else {
                items.append("\(hours) hr \(minutes) min")
            }
        }

        return items
    }

    var body: some View {
        VStack {
            ShowDetailsHeader(movie: movie)

            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Text("\(metadataItems.joined(separator: " ・ "))")
                    Spacer()
                }

                if let voteAverage = movie.voteAverage {
                    VoteLabel(voteAverage: voteAverage)
                }
            }
            .padding(.horizontal, 20)
            .textCase(.none)
            .foregroundColor(.secondary)
            .font(Font.caption.weight(.bold))
            .multilineTextAlignment(.center)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

}

struct MovieDetailsHeader_Previews: PreviewProvider {

    static var previews: some View {
        let movie = Movie(
            id: 1,
            title: "Fight Club",
            overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
            runtime: TimeInterval(120 * 60),
            genres: [
                Genre(id: 1, name: "Drama"),
                Genre(id: 2, name: "Action")
            ],
            releaseDate: Date(timeIntervalSinceNow: 0),
            voteAverage: 9
        )

        return NavigationView {
            List {
                Section(header: MovieDetailsHeader(movie: movie)) {
                    EmptyView()
                }
            }
        }
    }

}
