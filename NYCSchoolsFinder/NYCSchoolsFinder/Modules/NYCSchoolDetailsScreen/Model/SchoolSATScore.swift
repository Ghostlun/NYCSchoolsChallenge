//
//  SchoolACTScores.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/17/22.
//

import Foundation

struct SchoolSATScore: Codable {
    var name: String
    var numberOfTestTakers: String
    var readingAvgScore: String
    var mathAvgScore: String
    var writingAvgScore: String
    
    enum CodingKeys: String, CodingKey {
        case name = "school_name"
        case numberOfTestTakers = "num_of_sat_test_takers"
        case readingAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
}
