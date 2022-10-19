//
//  NYCSchoolDetailsViewModel.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/16/22.
//

import Foundation

protocol NYCSchoolDetailsViewModelDelegate: AnyObject {
    func hideLoader()
    func showLoader()
    func didFailWith(error: AppError)
    func reloadData()
}

class NYCSchoolDetailsViewModel {
    var schoolSATScore: SchoolSATScore?
    var scoreList: [SATScore] = []
    var schoolInfo: NYCSchool
    
    var name: String {
        return schoolInfo.schoolName
    }
    var phoneNumber: String {
        return schoolInfo.phoneNumber
    }
    var address: String {
        let addressLine = schoolInfo.address.components(separatedBy: "(")
        return addressLine[0]
    }
    var website: String {
        return schoolInfo.website
    }
    
    var overview: String {
        return schoolInfo.overview
    }
    
    var headerText: String {
        if scoreList.isEmpty {
            return "Your Selected School doesn't support SAT Score Data"
        }
        return "# of test takers: \(schoolSATScore?.numberOfTestTakers ?? "")"
    }
    
    var addressUrlString: String {
        return "https://\(schoolInfo.website)"
    }
    
    weak var delegate: NYCSchoolDetailsViewModelDelegate?
    
    init(schoolInfo: NYCSchool, delegate: NYCSchoolDetailsViewModelDelegate) {
        self.schoolInfo = schoolInfo
        self.delegate = delegate
    }
    
    func createDataSource(satScore: SchoolSATScore) {
        scoreList = [SATScore(subject: "Reading: ", score: satScore.readingAvgScore),
                     SATScore(subject: "Math: ", score: satScore.mathAvgScore),
                     SATScore(subject: "Writing: ", score: satScore.writingAvgScore)]
        
    }
    
    func fetchSATScores(completion: @escaping (String) -> Void) {
        self.delegate?.showLoader()
        NetworkManager.manager.fetch(url: NYCSchoolEndPoint.searchACTScores(code: schoolInfo.id).address) { [weak self](result: Result<[SchoolSATScore], AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let schoolSATScore = response.first {
                    self.schoolSATScore = schoolSATScore
                    self.createDataSource(satScore: schoolSATScore)
                } else {
                    self.delegate?.didFailWith(error: .dataSourceMissing)
                }
                self.delegate?.hideLoader()
            case .failure(let error):
                self.delegate?.didFailWith(error: error)
            }
            self.delegate?.reloadData()
        }
    }
    
    func numberOfRows() -> Int {
        scoreList.count
    }
    
    func getSATScoreInformation(index: Int) -> SATScore {
        return scoreList[index]
    }
}
