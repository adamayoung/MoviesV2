//
//  PosterImageMetadata.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation

struct PosterImageMetadata: Identifiable, Equatable {

    static let aspectRatio: Float = 100 / 150

    let url: URL
    let lowDataURL: URL
    let originalURL: URL

    var id: URL {
        url
    }

}
