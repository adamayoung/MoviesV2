//
//  SearchManaging.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol SearchManaging {

    func search(query: String) -> AnyPublisher<[MultiTypeListItem], Never>
}
