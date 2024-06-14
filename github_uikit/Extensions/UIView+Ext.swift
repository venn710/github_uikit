//
//  UIView+Ext.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 13/06/24.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor)
        ])
        
    }
    
    // Variadic Parameters which takes in zero or more parameters of defined type.
    func addSubViews(_ list: UIView...) {
        for view in list {
            addSubview(view)
        }
    }
}
