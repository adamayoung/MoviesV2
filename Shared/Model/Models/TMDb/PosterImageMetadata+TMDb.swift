//
//  PosterImageMetadata+TMDb.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation
import TMDb

extension PosterImageMetadata {

    init?(posterURLProvider: PosterURLProviding) {
        guard
            let url = posterURLProvider.posterLargeURL,
            let lowDataURL = posterURLProvider.posterSmallURL,
            let originalURL = posterURLProvider.posterOriginalURL
        else {
            return nil
        }

        self.init(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
    }

}
