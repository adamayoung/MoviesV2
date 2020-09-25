//
//  StillImageMetadata.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation

struct StillImageMetadata: Identifiable, Equatable {

    static let aspectRatio: Float = 500 / 281

    let url: URL
    let lowDataURL: URL
    let originalURL: URL

    var id: URL {
        url
    }

}
