//
//  NYCSchoolsDetailsViewController.swift
//  NYCSchoolsFinderTests
//
//  Created by Yoonha Kim on 10/18/22.
//

import XCTest
@testable import NYCSchoolsFinder

class NYCDetailsViewModelSpec: XCTestCase {
    
    var subject: NYCSchoolDetailsViewModel!
    var mockDelegate: MockNYCDetailsViewModelDelegate!
    
    override func setUp() {
        mockDelegate = MockNYCDetailsViewModelDelegate()
        subject = NYCSchoolDetailsViewModel(schoolInfo: NYCSchool(id: "01M292",
                                                                  schoolName: "testHighSchool",
                                                                  phoneNumber: "212-524-4360",
                                                                  address: "10 East 15th Street, Manhattan NY 10003",
                                                                  website: "admissions@theclintonschool.net",
                                                                  overview: "testOverview"),
                                            delegate: mockDelegate)
        super.setUp()
    }
    
    func testNYCSchoolDetailsViewModelInit() {
        subject.scoreList = []
        XCTAssertEqual(subject.name, "testHighSchool")
        XCTAssertEqual(subject.phoneNumber, "212-524-4360")
        XCTAssertEqual(subject.address, "10 East 15th Street, Manhattan NY 10003")
        XCTAssertEqual(subject.website, "admissions@theclintonschool.net")
        XCTAssertEqual(subject.overview, "testOverview")
        XCTAssertEqual(subject.headerText, "Your Selected School doesn't support SAT Score Data")
        XCTAssertEqual(subject.addressUrlString, "https://admissions@theclintonschool.net")
    }
    
    func testNumberOfRows() {
        subject.scoreList = []
        XCTAssertEqual(subject.numberOfRows(), 0)
    }
    
    func testGetSATScoreInformation() {
        subject.scoreList = [SATScore(subject: "Math", score: "32")]
        XCTAssertEqual(subject.getSATScoreInformation(index: 0), subject.scoreList[0])
    }
    
    func testFetchSATScoresSuccess() {
        subject.fetchSATScores{ (completion: String) in }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.mockDelegate.showLoaderCalled, true)
            XCTAssertEqual(self.mockDelegate.reloadDataCalled, true)
            XCTAssertEqual(self.mockDelegate.hideLoaderCalled, true)
        }
    }
    
    func testFetchSATScoresFails() {
        subject.schoolInfo.id = ""
        subject.fetchSATScores{ (completion: String) in }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.mockDelegate.reloadDataCalled, true)
            XCTAssertEqual(self.mockDelegate.hideLoaderCalled, true)
            XCTAssertEqual(self.mockDelegate.didFail, true)
            XCTAssertEqual(self.mockDelegate.showLoaderCalled, true)
        }
    }
}
