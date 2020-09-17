//
//  MovieStore.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import Combine
import Foundation

final class MovieStore: ObservableObject {

    private static let topLimit = 10

    var trending: [Movie] {
        trendingIDs.compactMap { movies[$0] }
    }

    var topTrending: [Movie] {
        Array(trendingIDs.prefix(Self.topLimit))
            .compactMap { movies[$0] }
    }

    var discover: [Movie] {
        discoverIDs.compactMap { movies[$0] }
    }

    var topDiscover: [Movie] {
        Array(discoverIDs.prefix(Self.topLimit))
            .compactMap { movies[$0] }
    }

    var favourites: [Movie] {
        favouriteIDs.compactMap { movies[$0] }
    }

    var topFavourites: [Movie] {
        Array(favouriteIDs.prefix(Self.topLimit))
            .compactMap { movies[$0] }
    }

    private let moviesManager: MoviesManager

    @Published private var movies: [Movie.ID: Movie] = [:]
    @Published private var trendingIDs: [Movie.ID] = []
    @Published private var discoverIDs: [Movie.ID] = []
    @Published private var favouriteIDs: [Movie.ID] = []
    @Published private var recommendationsIDs: [Movie.ID: [Movie.ID]] = [:]
    @Published private var credits: [Movie.ID: Credits] = [:]

    private var cancellables = Set<AnyCancellable>()
    private var isFetchingTrending = false
    private var currentTrendingPage = 0
    private var isMoreTrendingAvailable = true
    private var isFetchingDiscover = false
    private var currentDiscoverPage = 0
    private var isMoreDiscoverAvailable = true

    init(moviesManager: MoviesManager = TMDbMoviesManager()) {
        self.moviesManager = moviesManager
    }

    func movie(withID id: Movie.ID) -> Movie? {
        movies[id]
    }

    func credits(forMovie movieID: Movie.ID) -> Credits? {
        credits[movieID]
    }

    func recommendations(forMovie movieID: Movie.ID) -> [Movie]? {
        recommendationsIDs[movieID]?.compactMap { movies[$0] }
    }

}

extension MovieStore {

    func fetchTrending(completionHandler: ((Error?) -> Void)? = nil) {
        guard !isFetchingTrending, isMoreTrendingAvailable else {
            completionHandler?(nil)
            return
        }

        isFetchingTrending = true
        currentTrendingPage += 1

        return moviesManager.fetchTrending(page: currentTrendingPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetchingTrending = false

                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] movies in
                guard !movies.isEmpty else {
                    self?.isMoreTrendingAvailable = false
                    return
                }

                self?.appendTrending(movies: movies)
            })
            .store(in: &cancellables)
    }

    func fetchNextTrendingIfNeeded(currentMovie: Movie, offset: Int, completionHandler: ((Error?) -> Void)? = nil) {
        let index = trendingIDs.firstIndex(where: { $0 == currentMovie.id })
        let thresholdIndex = trendingIDs.index(trendingIDs.endIndex, offsetBy: -offset)
        guard index == thresholdIndex else {
            completionHandler?(nil)
            return
        }

        fetchTrending(completionHandler: completionHandler)
    }

    func fetchDiscover(completionHandler: ((Error?) -> Void)? = nil) {
        guard !isFetchingDiscover, isMoreDiscoverAvailable else {
            completionHandler?(nil)
            return
        }

        isFetchingDiscover = true
        currentDiscoverPage += 1

        return moviesManager.fetchDiscover(page: currentDiscoverPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetchingDiscover = false

                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] movies in
                guard !movies.isEmpty else {
                    self?.isMoreDiscoverAvailable = false
                    return
                }

                self?.appendDiscover(movies: movies)
            })
            .store(in: &cancellables)
    }

    func fetchNextDiscoverIfNeeded(currentMovie: Movie, offset: Int, completionHandler: ((Error?) -> Void)? = nil) {
        let index = discoverIDs.firstIndex(where: { $0 == currentMovie.id })
        let thresholdIndex = discoverIDs.index(discoverIDs.endIndex, offsetBy: -offset)
        guard index == thresholdIndex else {
            completionHandler?(nil)
            return
        }

        fetchDiscover(completionHandler: completionHandler)
    }

    func fetchMovie(withID id: Movie.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard movies[id] == nil else {
            completionHandler?(nil)
            return
        }

        moviesManager.fetchMovie(withID: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] movie in
                guard let movie = movie else {
                    return
                }

                self?.movies[movie.id] = movie
            })
            .store(in: &cancellables)
    }

    func fetchCredits(forMovie movieID: Movie.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard credits[movieID] == nil else {
            completionHandler?(nil)
            return
        }

        moviesManager.fetchCredits(forMovie: movieID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] credits in
                self?.credits[movieID] = credits
            })
            .store(in: &cancellables)
    }

    func fetchRecommendations(forMovie movieID: Movie.ID, completionHandler: ((Error?) -> Void)? = nil) {
        guard recommendations(forMovie: movieID) == nil else {
            completionHandler?(nil)
            return
        }

        moviesManager.fetchRecommendations(forMovie: movieID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    completionHandler?(nil)

                case .failure(let error):
                    completionHandler?(error)
                }
            }, receiveValue: { [weak self] recommendations in
                var recommendationIDs = self?.recommendationsIDs[movieID] ?? []
                recommendations.forEach {
                    self?.movies[$0.id] = $0
                    recommendationIDs.append($0.id)
                }
                self?.recommendationsIDs[movieID] = recommendationIDs
            })
            .store(in: &cancellables)
    }

}

extension MovieStore {

    private func appendTrending(movies: [Movie]) {
        var trendingIDs = self.trendingIDs
        movies.forEach {
            self.movies[$0.id] = $0
            if !trendingIDs.contains($0.id) {
                trendingIDs.append($0.id)
            }
        }
        self.trendingIDs = trendingIDs
    }

    private func appendDiscover(movies: [Movie]) {
        var discoverIDs = self.discoverIDs
        movies.forEach {
            self.movies[$0.id] = $0
            if !discoverIDs.contains($0.id) {
                discoverIDs.append($0.id)
            }
        }
        self.discoverIDs = discoverIDs
    }

}
