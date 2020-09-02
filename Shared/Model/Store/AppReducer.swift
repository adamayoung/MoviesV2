//
//  AppReduxStore.swift
//  Movies
//
//  Created by Adam Young on 25/08/2020.
//

import CloudKit
import Combine
import Foundation

func appReducer(state: inout AppState, action: AppAction, environment: AppEnvironment) -> AnyPublisher<AppAction, Never> {
    switch action {
    case .handleRemoteNotification(let userInfo):
        return handleRemoteNotification(userInfo: userInfo)

    case .movies(let action):
        return moviesReducer(state: &state.movies, action: action, environment: environment)
            .map { .movies($0) }
            .eraseToAnyPublisher()

    case .people(let action):
        return peopleReducer(state: &state.people, action: action, environment: environment)
            .map { .people($0) }
            .eraseToAnyPublisher()

    case .search(let action):
        return searchReducer(state: &state.search, action: action, environment: environment)
            .map { .search($0) }
            .eraseToAnyPublisher()

    case .tvShows(let action):
        return tvShowsReducer(state: &state.tvShows, action: action, environment: environment)
            .map { .tvShows($0) }
            .eraseToAnyPublisher()
    }
}

private func handleRemoteNotification(userInfo: [AnyHashable: Any]) -> AnyPublisher<AppAction, Never> {
    if let userInfo = userInfo as? [String: NSObject],
       let notification = CKNotification(fromRemoteNotificationDictionary: userInfo) {
        return handleCloudKitNotification(notification: notification)
    }

    return Empty()
        .eraseToAnyPublisher()
}

private func handleCloudKitNotification(notification: CKNotification) -> AnyPublisher<AppAction, Never> {
    if notification.notificationType == .query, let queryNotification = notification as? CKQueryNotification {
        return handleCloudKitQueryNotification(notification: queryNotification)
    }

    return Empty()
        .eraseToAnyPublisher()

}

private func handleCloudKitQueryNotification(notification: CKQueryNotification) -> AnyPublisher<AppAction, Never> {
    if notification.queryNotificationReason == .recordCreated {
        if let idString = notification.recordID?.recordName, let id = Int(idString) {
            return Just(.movies(.syncFavouriteCreated(movieID: id)))
                .eraseToAnyPublisher()
        }

    }

    if notification.queryNotificationReason == .recordDeleted {
        if let idString = notification.recordID?.recordName, let id = Int(idString) {
            return Just(.movies(.syncFavouriteDeleted(movieID: id)))
                .eraseToAnyPublisher()
        }

    }

    return Empty()
        .eraseToAnyPublisher()

}
