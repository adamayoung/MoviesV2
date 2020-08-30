//
//  MovieExtended+TMDb.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Foundation
import TMDb

extension MovieExtended {

    init(movie: TMDb.Movie) {
        let aMovie = Movie(movie: movie)
        let credits: Credits? = {
            guard let credits = movie.credits  else {
                return nil
            }

            return Credits(credits: credits)
        }()

        let recommendations: [MovieListItem]? = {
            guard let recommendations = movie.recommendations  else {
                return nil
            }

            return MovieListItem.create(movies: recommendations.results)
        }()

        self.init(id: movie.id, movie: aMovie, credits: credits, recommendations: recommendations)
    }

}
