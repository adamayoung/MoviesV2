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

        let posterImage: PosterImageMetadata? = {
            guard
                let url = tvShow.posterURL,
                let lowDataURL = tvShow.posterLowDataURL,
                let originalURL = tvShow.posterOriginalURL
            else {
                return nil
            }

            return PosterImageMetadata(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
        }()

        let backdropImage: BackdropImageMetadata? = {
            guard
                let url = tvShow.backdropURL,
                let lowDataURL = tvShow.backdropLowDataURL,
                let originalURL = tvShow.backdropOriginalURL
            else {
                return nil
            }

            return BackdropImageMetadata(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
        }()

        self.init(id: Int(tvShow.tvShowID), name: name, overview: tvShow.overview, firstAirDate: tvShow.firstAirDate,
                  posterImage: posterImage, backdropImage: backdropImage)
    }

}

extension FavouriteTVShow {

    convenience init(context: NSManagedObjectContext, tvShow: TVShow) {
        self.init(context: context)
        self.tvShowID = Int64(tvShow.id)
        self.name = tvShow.name
        self.overview = tvShow.overview
        self.firstAirDate = tvShow.firstAirDate
        self.posterURL = tvShow.posterImage?.url
        self.posterLowDataURL = tvShow.posterImage?.lowDataURL
        self.posterOriginalURL = tvShow.posterImage?.originalURL
        self.backdropURL = tvShow.backdropImage?.url
        self.backdropLowDataURL = tvShow.backdropImage?.lowDataURL
        self.backdropOriginalURL = tvShow.backdropImage?.originalURL
        self.createdAt = Date()
    }

}
