//
//  TrendingTVShowWidget.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import Combine
import SwiftUI
import TMDb
import WidgetKit

struct TrendingTVShowWidget: Widget {

    private let kind = "TrendingTVShow"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TrendingTVShowEntryView(entry: entry)
        }
        .configurationDisplayName("Trending TV Show")
        .description("See the top trending TV show at the moment.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }

}

extension TrendingTVShowWidget {

    final class ProviderService {

        private var cancellables = Set<AnyCancellable>()
        private let tvShowService: TVShowService
        private let urlSession: URLSession

        init(tvShowService: TVShowService = TMDbTVShowService(), urlSession: URLSession = .shared) {
            TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
            self.tvShowService = tvShowService
            self.urlSession = urlSession
        }

        func fetch(completion: @escaping (Entry) -> Void) {
            tvShowService.fetchTrending(timeWindow: .day)
                .retry(5)
                .map(\.results)
                .map(\.first)
                .replaceError(with: nil)
                .flatMap { tvShow -> AnyPublisher<Entry, Never> in
                    let currentDate = Date()
                    guard
                        let thisTVShow = tvShow,
                        let backdropPath = thisTVShow.backdropPath,
                        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780")?
                            .appendingPathComponent(backdropPath.absoluteString)
                    else {
                        return Just(Entry(date: currentDate, name: tvShow?.name))
                            .eraseToAnyPublisher()
                    }

                    return self.urlSession.dataTaskPublisher(for: backdropURL)
                        .map { $0.data as Data? }
                        .replaceError(with: nil)
                        .map { Entry(date: currentDate, name: thisTVShow.name, backdropData: $0) }
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
            let entry = Entry(date: Date(), name: "Game of Thrones", backdropImageName: "TrendingTVShowPlaceholderBackdrop")
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

extension TrendingTVShowWidget {

    struct Entry: TimelineEntry {

        var date: Date
        var name: String?
        var backdropData: Data?
        var backdropImageName: String?

    }

}

struct TrendingTVShowPlaceholderView: View {

    public var body: some View {
        MovieWidgetView(type: .trendingTVShow)
    }

}

struct TrendingTVShowEntryView: View {

    var entry: TrendingTVShowWidget.Entry

    init(entry: TrendingTVShowWidget.Entry) {
        TMDbAPIClient.setAPIKey(AppConstants.theMovieDatabaseAPIKey)
        self.entry = entry
    }

    var body: some View {
        MovieWidgetView(type: .trendingTVShow, title: entry.name, backdropData: entry.backdropData, backdropImageName: entry.backdropImageName)
    }

}

struct TrendingTVShowWidget_Previews: PreviewProvider {

    static let entry = TrendingTVShowWidget.Entry(date: Date(), name: "Game of Thrones", backdropImageName: "TrendingTVShowPlaceholderBackdrop")

    static var previews: some View {
        Group {
            TrendingTVShowPlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            TrendingTVShowEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }

}
