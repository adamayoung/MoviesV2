//
//  TrendingMovieWidget.swift
//  Movies (iOS Widgets)
//
//  Created by Adam Young on 15/07/2020.
//

import Combine
import SwiftUI
import TMDb
import WidgetKit

struct TrendingMovieWidget: Widget {

    private let kind = "TrendingMovie"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TrendingMovieEntryView(entry: entry)
        }
        .configurationDisplayName("Trending Movie")
        .description("See the top trending movie at the moment.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }

}

extension TrendingMovieWidget {

    final class ProviderService {

        private var cancellables = Set<AnyCancellable>()
        private let movieService: MovieService
        private let urlSession: URLSession

        init(movieService: MovieService = TMDbMovieService(), urlSession: URLSession = .shared) {
            TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
            self.movieService = movieService
            self.urlSession = urlSession
        }

        func fetch(completion: @escaping (Entry) -> Void) {
            movieService.fetchTrending(timeWindow: .day)
                .retry(5)
                .map(\.results)
                .map(\.first)
                .replaceError(with: nil)
                .flatMap { movie -> AnyPublisher<Entry, Never> in
                    let currentDate = Date()
                    guard
                        let thisMovie = movie,
                        let backdropPath = thisMovie.backdropPath,
                        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780")?
                            .appendingPathComponent(backdropPath.absoluteString)
                    else {
                        return Just(Entry(date: currentDate, title: movie?.title))
                            .eraseToAnyPublisher()
                    }

                    return self.urlSession.dataTaskPublisher(for: backdropURL)
                        .map { $0.data as Data? }
                        .replaceError(with: nil)
                        .map { Entry(date: currentDate, title: thisMovie.title, backdropData: $0) }
                        .eraseToAnyPublisher()
                }
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: completion)
                .store(in: &cancellables)
        }
    }

    struct Provider: TimelineProvider {

        private let service: ProviderService

        init(service: ProviderService = .init()) {
            self.service = service
        }

        func snapshot(with context: Context, completion: @escaping (Entry) -> Void) {
            let entry = Entry(date: Date(), title: "The Old Guard", backdropImageName: "TrendingMoviePlaceholderBackdrop")
            completion(entry)
        }

        func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
            let currentDate = Date()
            let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
            service.fetch { entry in
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                completion(timeline)
            }
        }

    }

}

extension TrendingMovieWidget {

    struct Entry: TimelineEntry {

        var date: Date
        var title: String?
        var backdropData: Data?
        var backdropImageName: String?

    }

}

struct TrendingMoviePlaceholderView: View {

    var body: some View {
        MovieWidgetView(type: .trendingMovie)
    }

}

struct TrendingMovieEntryView: View {

    var entry: TrendingMovieWidget.Entry

    init(entry: TrendingMovieWidget.Entry) {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
        self.entry = entry
    }

    var body: some View {
        MovieWidgetView(type: .trendingMovie, title: entry.title, backdropData: entry.backdropData, backdropImageName: entry.backdropImageName)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }

}

struct TrendingMovieWidget_Previews: PreviewProvider {

    static let entry = TrendingMovieWidget.Entry(date: Date(), title: "The Old Guard", backdropImageName: "TrendingMoviePlaceholderBackdrop")

    static var previews: some View {
        Group {
            TrendingMoviePlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            TrendingMovieEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            TrendingMovieEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }

}
