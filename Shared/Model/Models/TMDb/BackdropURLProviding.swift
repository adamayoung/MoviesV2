//
//  BackdropURLProviding.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

protocol BackdropURLProviding: BaseImageURLProviding {

    var backdropPath: URL? { get }
    var backdropURL: URL? { get }

}

extension BackdropURLProviding {

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else {
            return nil
        }

        return baseImageURL.appendingPathComponent(backdropPath.absoluteString)
    }

}
