//
//  ViewController.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/15/22.
//

import UIKit

class NYCSchoolListViewController: UIViewController {
    
    lazy var viewModel = NYCSchoolViewModel(delegate: self)
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            self.activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYC School List"
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: NYCSchoolTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NYCSchoolTableViewCell.reuseIdentifier)
        self.loadNYCSchools()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let schoolInfo = sender as? NYCSchool else { return }
        if (segue.identifier == "nycSchoolDetails") {
            guard let vc = segue.destination as? NYCSchoolDetailsViewController else { return }
            vc.schoolInfo = schoolInfo
        }
    }
    
    func loadNYCSchools() {
        viewModel.fetchSchoolInformation { _ in }
    }
}
extension NYCSchoolListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.getCellViewModel(index: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCSchoolTableViewCell.reuseIdentifier, for: indexPath) as? NYCSchoolTableViewCell else { return UITableViewCell() }
        cell.populate(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nycSchoolList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let schoolInfo = viewModel.nycSchoolList[indexPath.row]
        self.performSegue(withIdentifier: "nycSchoolDetails", sender: schoolInfo)
    }
}
extension NYCSchoolListViewController: NYCSchoolViewModelProtocol {
    func showLoader() {
        self.activityIndicatorView.startAnimating()
    }
    
    func hideLoader() {
        self.activityIndicatorView.stopAnimating()
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
    
    func didFailWith(error: AppError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
