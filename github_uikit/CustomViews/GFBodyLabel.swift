//
//  GFBodyLabel.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 10/04/24.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(bodyTextAlignment: NSTextAlignment, bodyTextColor: UIColor = .secondaryLabel){
        super.init(frame: .zero)
        
        textAlignment = bodyTextAlignment
        textColor = bodyTextColor
        font = UIFont.preferredFont(forTextStyle: .body)
        
        configure()
    }
    
    private func configure() {
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
