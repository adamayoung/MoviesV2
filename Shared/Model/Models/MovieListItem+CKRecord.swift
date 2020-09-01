//
//  MovieListItem+CKRecord.swift
//  Movies
//
//  Created by Adam Young on 01/09/2020.
//

import CloudKit
import Foundation

extension MovieListItem {

    init?(record: CKRecord) {
        guard record.recordType == "FavouriteMovie" else {
            return nil
        }

        let recordName = record.recordID.recordName

        guard
            let id = Int(recordName),
            let title = record["title"] as? String,
            let popularity = record["popularity"] as? Float
        else {
            return nil
        }

        let posterURL: URL? = {
            guard let posterURLString = record["posterURL"] as? String else {
                return nil
            }

            return URL(string: posterURLString)
        }()

        let backdropURL: URL? = {
            guard let backdropURLString = record["backdropURL"] as? String else {
                return nil
            }

            return URL(string: backdropURLString)
        }()

        self.init(id: id, title: title, overview: record["overview"], releaseDate: record["releaseDate"],
                  posterURL: posterURL, backdropURL: backdropURL, popularity: popularity)
    }

    static func create(records: [CKRecord]) -> [Self] {
        records.compactMap(Self.init)
    }

}
