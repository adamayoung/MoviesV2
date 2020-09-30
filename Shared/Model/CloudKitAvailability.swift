//
//  CloudKitAvailability.swift
//  Movies
//
//  Created by Adam Young on 25/09/2020.
//

import CloudKit
import Foundation

final class CloudKitAvailability: ObservableObject {

    @Published var isAvailable = false

    private let defaultContainer: CKContainer
    private let notificationCenter: NotificationCenter

    init(defaultContainer: CKContainer = .default(), notificationCenter: NotificationCenter = .default) {
        self.defaultContainer = defaultContainer
        self.notificationCenter = notificationCenter

        updateIsAvailable()
        observeAccountStatusChanges()
    }

    private func updateIsAvailable() {
        defaultContainer.accountStatus { [weak self] accountStatus, _ in
            DispatchQueue.main.async {
                self?.isAvailable = accountStatus == .available
            }
        }
    }

    private func observeAccountStatusChanges() {
        notificationCenter.addObserver(self, selector: #selector(accountDidChange(_:)),
                                       name: Notification.Name.CKAccountChanged, object: nil)
    }

    @objc
    private func accountDidChange(_ notification: Notification) {
        updateIsAvailable()
    }

}
