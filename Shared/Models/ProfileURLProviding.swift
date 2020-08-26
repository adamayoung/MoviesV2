//
//  ProfileURLProviding.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

protocol ProfileURLProviding: BaseImageURLProviding {

    var profilePath: URL? { get }
    var profileURL: URL? { get }

}

extension ProfileURLProviding {

    var profileURL: URL? {
        guard let profilePath = profilePath else {
            return nil
        }

        return baseImageURL.appendingPathComponent(profilePath.absoluteString)
    }

}
