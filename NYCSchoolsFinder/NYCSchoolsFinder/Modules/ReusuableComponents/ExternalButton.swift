//
//  ExternalButton.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/17/22.
//

import Foundation
import UIKit

class ExternalButton: UIButton {
    var style: Style = .phone {
        didSet {
            updateDisplay()
        }
    }
    
    enum Style {
        case phone
        case address
        case website
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateDisplay()
    }
    
    private func updateDisplay() {
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        switch style {
        case .phone:
            setImage(UIImage(systemName: "phone"), for: .normal)
            semanticContentAttribute = .forceLeftToRight
        case .website:
            setImage(UIImage(systemName: "network"), for: .normal)
            semanticContentAttribute = .forceLeftToRight
        case .address:
            setImage(UIImage(systemName: "location"), for: .normal)
            semanticContentAttribute = .forceLeftToRight
            titleLabel?.lineBreakMode = .byWordWrapping
        }
    }
}
