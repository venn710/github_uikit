//
//  UIHelper.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 13/06/24.
//

import UIKit

enum UIHelper {
    /// Made it generic so we can pass any number of columns we want.
    static func configureCustomColumnCollectionViewLayout(in view: UIView, with columns: Int = 3) -> UICollectionViewFlowLayout {
        let width: Double = view.bounds.width
        let padding: Double = 12
        let minimumItemSpacing: Double = 10
        let availableWidth: Double = width - (padding * 2) - Double(columns - 1) * minimumItemSpacing
        let itemWidth: Double = availableWidth / Double(columns)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}
