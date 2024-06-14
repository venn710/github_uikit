//
//  GFAlertContainerView.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 13/06/24.
//

import UIKit

class GFAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}
