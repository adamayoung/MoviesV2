//
//  StillURLProviding.swift
//  Movies
//
//  Created by Adam Young on 10/09/2020.
//

import Foundation

protocol StillURLProviding: BaseImageURLProviding {

    var stillPath: URL? { get }
    var stillURL: URL? { get }

}

extension StillURLProviding {

    var stillURL: URL? {
        guard let stillPath = stillPath else {
            return nil
        }

        return baseImageURL.appendingPathComponent(stillPath.absoluteString)
    }

}
