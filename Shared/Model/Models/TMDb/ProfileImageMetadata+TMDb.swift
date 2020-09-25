//
//  ProfileImageMetadata+TMDb.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation
import TMDb

extension ProfileImageMetadata {

    init?(profileURLProvider: ProfileURLProviding) {
        guard
            let url = profileURLProvider.profileLargeURL,
            let lowDataURL = profileURLProvider.profileSmallURL,
            let originalURL = profileURLProvider.profileOriginalURL
        else {
            return nil
        }

        self.init(url: url, lowDataURL: lowDataURL, originalURL: originalURL)
    }

}
