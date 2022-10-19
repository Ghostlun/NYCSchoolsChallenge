//
//  MockNYCSchoolsDetailsViewModelDelegate.swift
//  NYCSchoolsFinderTests
//
//  Created by Yoonha Kim on 10/18/22.
//

import Foundation
@testable import NYCSchoolsFinder

class MockNYCDetailsViewModelDelegate: NYCSchoolDetailsViewModelDelegate {
    
    var hideLoaderCalled = false
    func hideLoader() {
        hideLoaderCalled = true
    }
    
    var showLoaderCalled = false
    func showLoader() {
        showLoaderCalled = true
    }
    
    var didFail = false
    var erorMessage: String = ""
    func didFailWith(error: AppError) {
        didFail = true
        erorMessage = error.descriptionErrorMessage
    }
    
    var reloadDataCalled = false
    func reloadData() {
        reloadDataCalled = true
    }
}
