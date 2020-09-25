//
//  BackdropImageMetadata.swift
//  Movies
//
//  Created by Adam Young on 18/09/2020.
//

import Foundation

struct BackdropImageMetadata: Identifiable, Equatable {

    static let aspectRatio: Float = 500 / 281

    let url: URL
    let lowDataURL: URL
    let originalURL: URL

    var id: URL {
        url
    }

}
