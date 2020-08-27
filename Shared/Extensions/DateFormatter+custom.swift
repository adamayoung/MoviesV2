//
//  DateFormatter+custom.swift
//  Movies
//
//  Created by Adam Young on 28/07/2020.
//

import Foundation

extension DateFormatter {

    static var year: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter
    }

    static var longDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }

}
