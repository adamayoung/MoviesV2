//
//  PersonCombinedCredits+TMDb.swift
//  Movies
//
//  Created by Adam Young on 27/08/2020.
//

import Foundation
import TMDb

extension PersonCombinedCredits {

    init(credits: TMDb.PersonCombinedCredits) {
        let cast = ShowListItem.create(showItems: credits.cast)
        let crew = ShowListItem.create(showItems: credits.crew)

        self.init(id: credits.id, cast: cast, crew: crew)
    }

}
