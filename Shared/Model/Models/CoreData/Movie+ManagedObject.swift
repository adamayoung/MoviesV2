//
//  Movie+ManagedObject.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import CoreData

extension Movie {

    init?(movie: FavouriteMovie) {
        guard let title = movie.title else {
            return nil
        }

        let posterImage: PosterImageMetadata? = {
            guard
                let url = movie.posterURL,
                let lowDataURL = movie.posterLowDataURL,
                let originalURL = movie.posterOriginalURL
            else {
                return nil
            }

            return PosterImageMetadata(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
        }()

        let backdropImage: BackdropImageMetadata? = {
            guard
                let url = movie.backdropURL,
                let lowDataURL = movie.backdropLowDataURL,
                let originalURL = movie.backdropOriginalURL
            else {
                return nil
            }

            return BackdropImageMetadata(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
        }()

        self.init(id: Int(movie.movieID), title: title, overview: movie.overview, releaseDate: movie.releaseDate,
                  posterImage: posterImage, backdropImage: backdropImage)
    }

}

extension FavouriteMovie {

    convenience init(context: NSManagedObjectContext, movie: Movie) {
        self.init(context: context)
        self.movieID = Int64(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.posterURL = movie.posterImage?.url
        self.posterLowDataURL = movie.posterImage?.lowDataURL
        self.posterOriginalURL = movie.posterImage?.originalURL
        self.backdropURL = movie.backdropImage?.url
        self.backdropLowDataURL = movie.backdropImage?.lowDataURL
        self.backdropOriginalURL = movie.backdropImage?.originalURL
        self.createdAt = Date()
    }

}
