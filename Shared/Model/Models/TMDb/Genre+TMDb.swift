//
//  Genre+TMDb.swift
//  Movies
//
//  Created by Adam Young on 16/09/2020.
//

import Foundation
import TMDb

extension Genre {

    init(model: TMDb.Genre) {
        self.init(id: model.id, name: model.name)
    }

    static func create(models: [TMDb.Genre]) -> [Genre] {
        models.map(Self.init)
    }

}
