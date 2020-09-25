//
//  BackdropImageMetadata+TMDb.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation
import TMDb

extension BackdropImageMetadata {

    init?(backdropURLProvider: BackdropURLProviding) {
        guard
            let url = backdropURLProvider.backdropLargeURL,
            let lowDataURL = backdropURLProvider.backdropSmallURL,
            let originalURL = backdropURLProvider.backdropOriginalURL
        else {
            return nil
        }

        self.init(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
    }

}
