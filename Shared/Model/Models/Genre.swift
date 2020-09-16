//
//  Genre.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import Foundation

struct Genre: Identifiable, Equatable {

    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

}
