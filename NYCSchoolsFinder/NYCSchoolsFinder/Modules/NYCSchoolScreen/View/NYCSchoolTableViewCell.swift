//
//  NYCSchoolTableViewCell.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/16/22.
//

import UIKit

class NYCSchoolTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!

    func populate(viewModel: NYCSchoolCellViewModel) {
        nameLabel.text = viewModel.name
        phoneNumberLabel.text = viewModel.phoneNumber
    }
}
