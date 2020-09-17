//
//  BaseImageURLProviding.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import Foundation

protocol BaseImageURLProviding {

    var baseImageURL: URL { get }

}

extension BaseImageURLProviding {

    var baseImageURL: URL {
        URL(string: "https://image.tmdb.org/t/p/")!
            .appendingPathComponent("w1280")
    }

}
