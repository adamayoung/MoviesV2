//
//  ConfigurationStore.swift
//  Movies
//
//  Created by Adam Young on 15/07/2020.
//

import Combine
import SwiftUI
import TMDb

final class ConfigurationStore: ObservableObject {

    static let shared = ConfigurationStore()

    private var cancellables = Set<AnyCancellable>()
    private let configurationService: ConfigurationService

    private var isFetching = false

    @Published private(set) var imagesConfiguration: ImagesConfiguration?

    init(configurationService: ConfigurationService = TMDbConfigurationService()) {
        self.configurationService = configurationService
    }

    func fetchIfNeeded() {
        guard !isFetching, imagesConfiguration == nil else {
            return
        }

        isFetching = true

        configurationService.fetch()
            .map(\.images)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isFetching = false
            }, receiveValue: { imagesConfiguration in
                self.imagesConfiguration = imagesConfiguration
            })
            .store(in: &cancellables)
    }

}

extension ImagesConfiguration {

  func imageURL(fromPath path: URL?) -> URL? {
    guard let path = path else {
      return nil
    }

    return secureBaseUrl
      .appendingPathComponent("w780")
      .appendingPathComponent(path.absoluteString)
  }

}
