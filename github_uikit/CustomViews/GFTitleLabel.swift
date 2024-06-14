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
    
    /*
     convenience initialisers are secondary, supporting initialisers for a class, we can define a convenience
     initialiser to call a designated initialiser from the same class as the convenience initialiser with some of
     the designated initialiser’s parameters set to default values.
     */
    convenience init(titleTextAlignment: NSTextAlignment, titleTextColor: UIColor, titleFontSize: CGFloat){
        // Here setting designated initialisers frame value to .zero by default.
        self.init(frame: .zero)
        
        self.textAlignment = titleTextAlignment
        self.textColor = titleTextColor
        self.font = UIFont.systemFont(ofSize: titleFontSize, weight: .bold)
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
