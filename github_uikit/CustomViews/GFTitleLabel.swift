//
//  GFTitleLabel.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 10/04/24.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(titleTextAlignment: NSTextAlignment, titleTextColor: UIColor, titleFontSize: CGFloat){
        super.init(frame: .zero)
        
        self.textAlignment = titleTextAlignment
        self.textColor = titleTextColor
        self.font = UIFont.systemFont(ofSize: titleFontSize, weight: .bold)
        
        configure()
    }
    
    private func configure() {
    
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
