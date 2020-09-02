//
//  CrewMember.swift
//  Movies
//
//  Created by Adam Young on 20/07/2020.
//

import Foundation

struct CrewMember: Identifiable, Equatable {

    let id: Int
    let creditID: String
    let name: String
    let job: String
    let department: String
    let gender: Gender
    let profileURL: URL?

    init(id: Int, creditID: String, name: String, job: String, department: String, gender: Gender = .unknown,
         profileURL: URL? = nil) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.job = job
        self.department = department
        self.gender = gender
        self.profileURL = profileURL
    }

}
