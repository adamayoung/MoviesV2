//
//  SearchManager.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol SearchManager {

    func search(query: String) -> AnyPublisher<[Media], Never>
}
