//
//  URL+DeepLink.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import Foundation

extension URL {

    var isDeeplink: Bool {
        return scheme == "movies"
    }

}
