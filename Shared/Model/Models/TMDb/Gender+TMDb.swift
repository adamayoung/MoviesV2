//
//  Gender+TMDb.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation
import TMDb

extension Gender {

    init(dto: GenderDTO) {
        switch dto {
        case .unknown:
            self = .unknown

        case .female:
            self = .female

        case .male:
            self = .male

        case .other:
            self = .other
        }
    }

}
