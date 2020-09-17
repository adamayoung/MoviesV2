//
//  PosterURLProviding.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

protocol PosterURLProviding: BaseImageURLProviding {

    var posterPath: URL? { get }
    var posterURL: URL? { get }

}

extension PosterURLProviding {

    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }

        return baseImageURL.appendingPathComponent(posterPath.absoluteString)
    }

}
