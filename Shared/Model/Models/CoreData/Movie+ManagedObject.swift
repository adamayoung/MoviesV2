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

        self.init(id: Int(movie.movieID), title: title, overview: movie.overview, releaseDate: movie.releaseDate,
                  posterURL: movie.posterURL, backdropURL: movie.backdropURL)
    }

}

extension FavouriteMovie {

    convenience init(context: NSManagedObjectContext, movie: Movie) {
        self.init(context: context)
        self.movieID = Int64(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.posterURL = movie.posterURL
        self.backdropURL = movie.backdropURL
        self.createdAt = Date()
    }

}
