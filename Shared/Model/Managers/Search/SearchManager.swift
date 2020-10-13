//
//  SearchManager.swift
//  Movies
//
//  Created by Adam Young on 28/08/2020.
//

import Combine
import Foundation

protocol SearchManager {

    func search(query: String, page: Int) -> AnyPublisher<[Media], Never>
}

extension SearchManager {

    func search(query: String, page: Int = 1) -> AnyPublisher<[Media], Never> {
        search(query: query, page: page)
    }

}
