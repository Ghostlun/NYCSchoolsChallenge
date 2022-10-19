//
//  NYCSchoolEndPoint.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/17/22.
//

import Foundation
enum NYCSchoolEndPoint {
    case searchWholeListOfSchools
    case searchACTScores(code: String)
    
    var address: String {
        switch self {
        case .searchWholeListOfSchools:
            return "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        case .searchACTScores(let code):
            return "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(code)"
        }
    }
    
}
