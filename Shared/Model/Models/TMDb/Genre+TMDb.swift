//
//  Genre+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import Foundation
import TMDb

extension Genre {

    init(dto: GenreDTO) {
        self.init(id: dto.id, name: dto.name)
    }

    static func create(dtos: [GenreDTO]) -> [Genre] {
        dtos.map(Self.init)
    }

}
