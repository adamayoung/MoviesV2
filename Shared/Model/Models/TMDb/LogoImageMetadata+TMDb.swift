//
//  LogoImageMetadata+TMDb.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation
import TMDb

extension LogoImageMetadata {

    init?(logoURLProvider: LogoURLProviding) {
        guard
            let url = logoURLProvider.logoLargeURL,
            let lowDataURL = logoURLProvider.logoSmallURL,
            let originalURL = logoURLProvider.logoOriginalURL
        else {
            return nil
        }

        self.init(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
    }

}
