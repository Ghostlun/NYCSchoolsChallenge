//
//  NYCSchool.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/16/22.
//

import Foundation

struct NYCSchoolResponse: Codable {
    var nycSchools: [NYCSchool]
}

struct NYCSchool: Codable {
    var id: String
    var schoolName: String
    var phoneNumber: String
    var address: String
    var website: String
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case phoneNumber = "phone_number"
        case address = "location"
        case overview = "overview_paragraph"
        case website = "website"
    }
}
