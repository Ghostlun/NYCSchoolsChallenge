//
//  NYCSchoolViewModelSpec.swift
//  NYCSchoolsFinderTests
//
//  Created by Yoonha Kim on 10/18/22.
//

import XCTest
@testable import NYCSchoolsFinder

class NYCSchoolViewModelSpec: XCTestCase {
    
    var subject: NYCSchoolViewModel!
    var mockDelegate: MockNYCSchoolViewModelDelegate!
    var testSchool: NYCSchool!
    
    override func setUp() {
        mockDelegate = MockNYCSchoolViewModelDelegate()
        subject = NYCSchoolViewModel(delegate: mockDelegate)
        testSchool = NYCSchool(id: "01M292",
                               schoolName: "testHighSchool",
                               phoneNumber: "212-524-4360",
                               address: "10 East 15th Street, Manhattan NY 10003",
                               website: "admissions@theclintonschool.net",
                               overview: "testOverview")
        subject.nycSchoolList = [testSchool]
        super.setUp()
    }
    
    func testNumberOfRowInSection() {
        XCTAssertEqual(subject.numberOfRowInSection(), 1)
    }
    
    func testGetCellViewModel() {
        XCTAssertEqual(subject.getCellViewModel(index: 0), NYCSchoolCellViewModel(nycSchool: testSchool))
    }
    
    func testFetchSchoolInformation() {
        subject.fetchSchoolInformation{ (completion: String) in }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.mockDelegate.showLoaderCalled, true)
            XCTAssertEqual(self.mockDelegate.reloadDataCalled, true)
            XCTAssertEqual(self.mockDelegate.hideLoaderCalled, true)
        }
    }
}
