//
//  MovieStore.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import Combine
import Foundation
import TMDb

class BaseMovieStore {

    @Published var trendingMovies = [MovieListItem]()
    @Published var isFetchingTrending = false
    @Published var discoverMovies = [MovieListItem]()
    @Published var isFetchingDiscover = false

}

protocol MovieStorable: BaseMovieStore {

    func fetchTrending()
    func fetchNextTrendingPageIfNeeded(currentMovie id: MovieListItem.ID)

    func fetchDiscover()
    func fetchNextDiscoverPageIfNeeded(currentMovie id: MovieListItem.ID)

    func fetchMovie(withID id: Movie.ID)
    func moviePublisher(forID id: Movie.ID) -> AnyPublisher<Movie, Never>

    func fetchRecommendations(forMovie movieID: Movie.ID)
    func recommendationsPublisher(forMovie movieID: Movie.ID)-> AnyPublisher<[MovieListItem], Never>

    func search(query: String) -> AnyPublisher<[MovieListItem], Error>

}

final class MovieStore: BaseMovieStore, MovieStorable, ObservableObject {

    private static let thresholdOffset = 15

    static let shared = MovieStore()

    private let movieService: MovieService

    private var cancellables = Set<AnyCancellable>()
    private var movieListItems = [MovieListItem.ID: MovieListItem]()
    private var currentTrendingPage = 1
    private var canFetchMoreTrending = true
    private var currentDiscoverPage = 1
    private var canFetchMoreDiscover = true

    @Published private var trendingMovieIDs = [MovieListItem.ID]()
    @Published private var discoverMovieIDs = [MovieListItem.ID]()
    @Published private var movies = [Movie.ID: Movie]()
    @Published private var recommendations = [Movie.ID: [MovieListItem]]()

    init(movieService: MovieService = TMDbMovieService()) {
        self.movieService = movieService
        super.init()

        $trendingMovieIDs
            .removeDuplicates()
            .map { $0.compactMap { self.movieListItems[$0] } }
            .assign(to: \.trendingMovies, on: self)
            .store(in: &cancellables)

        $discoverMovieIDs
            .removeDuplicates()
            .map { $0.compactMap { self.movieListItems[$0] } }
            .assign(to: \.discoverMovies, on: self)
            .store(in: &cancellables)

        fetchTrending()
        fetchDiscover()
    }

    func fetchTrending() {
        guard canFetchMoreTrending, !isFetchingTrending else {
            return
        }

        isFetchingTrending = true

        movieService.fetchTrending(timeWindow: .day, page: currentTrendingPage)
            .catch { _ in
                Empty<MoviePageableListResult, Never>()
            }
            .map(\.results)
            .map(MovieListItem.create)
            .sink(receiveCompletion: { _ in
                self.isFetchingTrending = false
            }, receiveValue: { movies in
                self.mergeTrendingMovies(movies)
                self.currentTrendingPage += 1
                self.canFetchMoreTrending = !movies.isEmpty
            })
            .store(in: &cancellables)
    }

    func fetchNextTrendingPageIfNeeded(currentMovie id: MovieListItem.ID) {
        let thresholdIndex = trendingMovieIDs.index(trendingMovieIDs.endIndex, offsetBy: -Self.thresholdOffset)
        guard trendingMovieIDs.firstIndex(where: { $0 == id }) == thresholdIndex else {
            return
        }

        fetchTrending()
    }

    func fetchDiscover() {
        guard canFetchMoreDiscover, !isFetchingDiscover else {
            return
        }

        isFetchingDiscover = true

        movieService.fetchDiscover(page: currentDiscoverPage)
            .catch { _ in
                Empty<MoviePageableListResult, Never>()
            }
            .map(\.results)
            .map(MovieListItem.create)
            .sink(receiveCompletion: { _ in
                self.isFetchingDiscover = false
            }, receiveValue: { movies in
                self.mergeDiscoverMovies(movies)
                self.currentDiscoverPage += 1
                self.canFetchMoreDiscover = !movies.isEmpty
            })
            .store(in: &cancellables)
    }

    func fetchNextDiscoverPageIfNeeded(currentMovie id: MovieListItem.ID) {
        let thresholdIndex = discoverMovieIDs.index(discoverMovieIDs.endIndex, offsetBy: -Self.thresholdOffset)
        guard discoverMovieIDs.firstIndex(where: { $0 == id }) == thresholdIndex else {
            return
        }

        fetchDiscover()
    }

    func fetchMovie(withID id: Movie.ID) {
        guard movies[id] == nil else {
            return
        }

        movieService.fetch(id: id)
            .map(Movie.init)
            .catch { _ in
                Empty<Movie, Never>()
            }
            .sink(receiveCompletion: { _ in
            }, receiveValue: { movie in
                var movies = self.movies
                movies[movie.id] = movie
                self.movies = movies
            })
            .store(in: &cancellables)
    }

    func moviePublisher(forID id: Movie.ID) -> AnyPublisher<Movie, Never> {
        $movies
            .map { $0[id] }
            .filter { $0 != nil }
            .map { $0! }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func fetchRecommendations(forMovie movieID: Movie.ID) {
        guard recommendations[movieID] == nil else {
            return
        }

        movieService.fetchRecommendations(forMovie: movieID)
            .catch { _ in
                Empty<MoviePageableListResult, Never>()
            }
            .map(\.results)
            .map(MovieListItem.create)
            .sink(receiveValue: { movies in
                self.recommendations[movieID] = movies
            })
            .store(in: &cancellables)
    }

    func recommendationsPublisher(forMovie movieID: Movie.ID)-> AnyPublisher<[MovieListItem], Never> {
        $recommendations
            .map { $0[movieID] }
            .filter { $0 != nil }
            .map { $0! }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    func search(query: String) -> AnyPublisher<[MovieListItem], Error> {
        movieService.search(query: query)
            .mapError { $0 as Error }
            .map(\.results)
            .map(MovieListItem.create)
            .eraseToAnyPublisher()
    }

}

extension MovieStore {

    private func mergeTrendingMovies(_ movies: [MovieListItem]) {
        movies.forEach { movie in
            self.movieListItems[movie.id] = movie
            var trendingMovieIDs = self.trendingMovieIDs
            if !trendingMovieIDs.contains(movie.id) {
                trendingMovieIDs.append(movie.id)
            }

            self.trendingMovieIDs = trendingMovieIDs
        }
    }

    private func mergeDiscoverMovies(_ movies: [MovieListItem]) {
        movies.forEach { movie in
            self.movieListItems[movie.id] = movie
            var discoverMovieIDs = self.discoverMovieIDs
            if !discoverMovieIDs.contains(movie.id) {
                discoverMovieIDs.append(movie.id)
            }

            self.discoverMovieIDs = discoverMovieIDs
        }
    }

}
