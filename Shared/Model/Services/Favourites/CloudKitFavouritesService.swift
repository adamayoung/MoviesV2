//
//  CloudKitFavouritesService.swift
//  Movies
//
//  Created by Adam Young on 01/09/2020.
//

import Combine
import CloudKit
import Foundation

final class CloudKitFavouritesService: FavouritesService {

    static let favouriteMovieRecordType: CKRecord.RecordType = "FavouriteMovie"
    static let favouriteMoviesSubscriptionID: CKSubscription.ID = "MyFavouriteMovies"

    private let database: CKDatabase

    init(database: CKDatabase = CKContainer(identifier: "iCloud.uk.co.adam-young.Movies").privateCloudDatabase) {
        self.database = database

        subscribeToUpdates()
    }

    func addFavourite(movie: MovieListItem) -> AnyPublisher<Void, Error> {
        let recordID = CKRecord.ID(recordName: String(movie.id))
        let record = CKRecord(recordType: Self.favouriteMovieRecordType, recordID: recordID)
        record["title"] = movie.title
        record["overview"] = movie.overview
        record["releaseDate"] = movie.releaseDate
        record["posterURL"] = movie.posterURL?.absoluteString
        record["backdropURL"] = movie.backdropURL?.absoluteString
        record["popularity"] = movie.popularity

        return Future { [self] promise in
            self.database.save(record) { record, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                promise(.success(Void()))
            }
        }
        .eraseToAnyPublisher()
    }

    func removeFavourite(movie movieID: Movie.ID) -> AnyPublisher<Void, Error> {
        let recordID = CKRecord.ID(recordName: String(movieID))
        return Future { [self] promise in
            self.database.delete(withRecordID: recordID) { recordID, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                promise(.success(Void()))
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchFavourite(movie movieID: Movie.ID) -> AnyPublisher<MovieListItem?, Never> {
        let recordID = CKRecord.ID(recordName: String(movieID))
        return Future { [self] promise in
            self.database.fetch(withRecordID: recordID) { record, error in
                if error != nil {
                    promise(.success(nil))
                    return
                }

                guard let record = record else {
                    promise(.success(nil))
                    return
                }

                let movie = MovieListItem(record: record)
                promise(.success(movie))
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchFavouriteMovies() -> AnyPublisher<[MovieListItem], Never> {
        let query = CKQuery(recordType: Self.favouriteMovieRecordType, predicate: NSPredicate(value: true))
        return Future { [self] promise in
            self.database.perform(query, inZoneWith: nil) { records, error in
                if error != nil {
                    promise(.success([]))
                    return
                }

                guard let records = records else {
                    promise(.success([]))
                    return
                }

                let movies = MovieListItem.create(records: records)
                promise(.success(movies))
            }
        }
        .eraseToAnyPublisher()
    }
    
}

extension CloudKitFavouritesService {

    private func subscribeToUpdates() {
        let subscription = CKQuerySubscription(recordType: Self.favouriteMovieRecordType,
                                               predicate: NSPredicate(value: true),
                                               subscriptionID: Self.favouriteMoviesSubscriptionID,
                                               options: [.firesOnRecordCreation, .firesOnRecordDeletion])
        let info = CKSubscription.NotificationInfo()
        info.shouldSendContentAvailable = true
        info.shouldBadge = false
        info.alertBody = ""
        subscription.notificationInfo = info

        let createOperation = CKModifySubscriptionsOperation(subscriptionsToSave: [subscription], subscriptionIDsToDelete: nil)
        createOperation.modifySubscriptionsCompletionBlock = { _, _, error in
            if let error = error {
                print("Error creating subscription: \(error)")
                return
            }

            print("Subscription Created")
        }
        database.add(createOperation)
    }

}
