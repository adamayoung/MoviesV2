//
//  StillImageMetadata+TMDb.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation
import TMDb

extension StillImageMetadata {

    init?(stillURLProvider: StillURLProviding) {
        guard
            let url = stillURLProvider.stillLargeURL,
            let lowDataURL = stillURLProvider.stillSmallURL,
            let originalURL = stillURLProvider.stillOriginalURL
        else {
            return nil
        }

        self.init(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
    }

}
