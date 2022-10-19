//
//  SATScoreHeaderView.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/17/22.
//

import UIKit

class SATScoreHeaderView: UITableViewHeaderFooterView, CellReusable {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func populate(title: String) {
        titleLabel.text = title
    }
}
