//
//  NYCSchoolViewModel.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/15/22.
//

import Foundation

protocol NYCSchoolViewModelProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadData()
    func didFailWith(error: AppError)
}

class NYCSchoolViewModel {
    
    var nycSchoolList: [NYCSchool] = []
    weak var delegate: NYCSchoolViewModelProtocol?
    
    init(delegate: NYCSchoolViewModelProtocol) {
        self.delegate = delegate
    }
    
    func numberOfRowInSection() -> Int {
        nycSchoolList.count
    }
    
    func fetchSchoolInformation(completion: @escaping (String) -> Void) {
        self.delegate?.showLoader()
        NetworkManager.manager.fetch(url: NYCSchoolEndPoint.searchWholeListOfSchools.address) { [weak self](result: Result<[NYCSchool], AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.nycSchoolList = response
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.didFailWith(error: error)
            }
            self.delegate?.hideLoader()
        }
    }
    
    func getCellViewModel(index: Int) -> NYCSchoolCellViewModel {
        return NYCSchoolCellViewModel(nycSchool: nycSchoolList[index])
    }
    
    func handleSearch(text: String) {
        let strippedString = text.trimmingCharacters(in: .whitespaces).lowercased()
        nycSchoolList = nycSchoolList.filter({ item in
            return item.schoolName.contains(strippedString)
        })
        self.delegate?.reloadData()
    }
}
