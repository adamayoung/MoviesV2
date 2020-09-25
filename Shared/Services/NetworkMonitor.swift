//
//  NetworkMonitor.swift
//  Movies
//
//  Created by Adam Young on 18/09/2020.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {

    @Published private(set) var hasConnection = false

    private let monitor: NWPathMonitor

    init(monitor: NWPathMonitor = NWPathMonitor(), queue: DispatchQueue = DispatchQueue(label: "Monitor")) {
        self.monitor = monitor
        self.monitor.pathUpdateHandler = handler
        self.monitor.start(queue: queue)
    }

}

extension NetworkMonitor {

    private func handler(path: NWPath) {
        DispatchQueue.main.async { [weak self] in
            self?.hasConnection = path.status == .satisfied
        }

    }

}
