//
//  TVShow+ManagedObject.swift
//  Movies
//
//  Created by Adam Young on 17/09/2020.
//

import CoreData

extension TVShow {

    init?(tvShow: FavouriteTVShow) {
        guard let name = tvShow.name else {
            return nil
        }

        self.init(id: Int(tvShow.tvShowID), name: name, overview: tvShow.overview, firstAirDate: tvShow.firstAirDate,
                  posterURL: tvShow.posterURL, backdropURL: tvShow.backdropURL)
    }

}

extension FavouriteTVShow {

    convenience init(context: NSManagedObjectContext, tvShow: TVShow) {
        self.init(context: context)
        self.tvShowID = Int64(tvShow.id)
        self.name = tvShow.name
        self.overview = tvShow.overview
        self.firstAirDate = tvShow.firstAirDate
        self.posterURL = tvShow.posterURL
        self.backdropURL = tvShow.backdropURL
        self.createdAt = Date()
    }

}
