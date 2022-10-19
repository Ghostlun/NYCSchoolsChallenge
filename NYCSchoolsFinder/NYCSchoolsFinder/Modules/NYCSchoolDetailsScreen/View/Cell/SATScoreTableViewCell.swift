//
//  SATScoreTableViewCell.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/17/22.
//

import UIKit

class SATScoreTableViewCell: UITableViewCell, CellReusable {
    
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    func populate(scoreInfo: SATScore) {
        subjectLabel.text = scoreInfo.subject
        scoreLabel.text = scoreInfo.score
    }
}
