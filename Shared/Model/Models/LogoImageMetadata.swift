//
//  LogoImageMetadata.swift
//  Movies
//
//  Created by Adam Young on 24/09/2020.
//

import Foundation

struct LogoImageMetadata: Identifiable, Equatable {

    let url: URL
    let lowDataURL: URL
    let originalURL: URL

    var id: URL {
        url
    }

}
