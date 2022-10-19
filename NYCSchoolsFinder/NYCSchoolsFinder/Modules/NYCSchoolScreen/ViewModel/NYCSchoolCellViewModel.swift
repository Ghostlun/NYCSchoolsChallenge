//
//  NYCSchoolCellViewModel.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/16/22.
//

import Foundation

struct NYCSchoolCellViewModel: Equatable {
    
    var name: String
    var phoneNumber: String
    var website: String
    var overview: String
    
    init(nycSchool: NYCSchool) {
        self.name = nycSchool.schoolName
        self.website = nycSchool.website
        self.overview = nycSchool.overview
        self.phoneNumber = nycSchool.phoneNumber
    }
}
