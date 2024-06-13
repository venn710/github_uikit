//
//  GFEmptyStateView.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 13/06/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let titleLabel = GFTitleLabel(titleTextAlignment: .center, titleTextColor: .secondaryLabel, titleFontSize: 28)
    let imageLabel = UIImageView(image: GFImages.emptyStateLogo)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    convenience init(message: String) {
        self.init(frame: .zero)
        titleLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubViews(titleLabel, imageLabel)
        configureMessage()
        configureImage()
    }
    
    private func configureMessage() {
        titleLabel.numberOfLines = 3
        let labelCenterYConstant: Double = (DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed) ? -50 : -150
        let titleLabelCenterYAnchor = titleLabel.centerYAnchor.constraint(
            equalTo: self.centerYAnchor,
            constant: labelCenterYConstant
        )
        titleLabelCenterYAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        ])
    }
    
    private func configureImage() {
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        let imageBottomConstant: Double = (DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed) ? 80 : 40
        let imageBottomAnchor = imageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:imageBottomConstant)
        imageBottomAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            imageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 150),
            imageLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3)
        ])
    }
}
