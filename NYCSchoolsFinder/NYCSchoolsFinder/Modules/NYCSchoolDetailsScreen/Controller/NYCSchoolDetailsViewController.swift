//
//  NYCSchoolDetailsViewController.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/16/22.
//

import UIKit

class NYCSchoolDetailsViewController: UIViewController, NYCSchoolDetailsViewModelDelegate {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var schoolOverviewTextView: UITextView!
    @IBOutlet weak var schoolWebsiteButton: ExternalButton!
    @IBOutlet weak var schoolPhoneNumberButton: ExternalButton!
    @IBOutlet weak var schoolAddressButton: ExternalButton!
    @IBOutlet weak var tableView: UITableView!
    
    var schoolInfo: NYCSchool!
    lazy var viewModel = NYCSchoolDetailsViewModel(schoolInfo: schoolInfo, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: SATScoreTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SATScoreTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: SATScoreHeaderView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: SATScoreHeaderView.reuseIdentifier)
        self.navigationItem.backButtonTitle = "Back"
        self.title = "School Details"
        
        schoolWebsiteButton.style = .website
        schoolPhoneNumberButton.style = .phone
        schoolAddressButton.style = .address
        
        loadData()
        setupInitialView()
    }
    
    private func setupInitialView() {
        schoolNameLabel.text = viewModel.name
        schoolOverviewTextView.text = viewModel.overview
        schoolWebsiteButton.setTitle(viewModel.website, for: .normal)
        schoolPhoneNumberButton.setTitle(viewModel.phoneNumber, for: .normal)
        schoolAddressButton.setTitle(viewModel.address, for: .normal)
        
        activityIndicator.center = tableView.center
    }
    
    private func loadData() {
        viewModel.fetchSATScores(completion: { _ in})
    }
    
    @IBAction func callButtonClicked() {
        guard let url = URL(string: "TEL://\(viewModel.phoneNumber)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func openWebsite() {
        guard let url = URL(string: viewModel.addressUrlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func openMap() {
        let application = UIApplication.shared
        let appleMapUrl = "maps://"
        if application.canOpenURL(URL(string: appleMapUrl)!) {
            let addressWithoutSpaces = viewModel.address.replacingOccurrences(of: " ", with: "+")
            guard let addressUrl = URL(string: "\(appleMapUrl)?address=\(addressWithoutSpaces)") else { return }
            application.open(addressUrl)
            return
        }
    }
}
extension NYCSchoolDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let satScore = viewModel.getSATScoreInformation(index: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SATScoreTableViewCell.reuseIdentifier, for: indexPath) as? SATScoreTableViewCell else { return UITableViewCell() }
        cell.populate(scoreInfo: satScore)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SATScoreHeaderView.reuseIdentifier) as? SATScoreHeaderView else { return UIView() }
        headerView.populate(title: viewModel.headerText)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NYCSchoolDetailsViewController: NYCSchoolViewModelProtocol {
    func showLoader() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        self.activityIndicator.stopAnimating()
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
    
    func didFailWith(error: AppError) {
        let alert = UIAlertController(title: "Error", message: error.descriptionErrorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}


