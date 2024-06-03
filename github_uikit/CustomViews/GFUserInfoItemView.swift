//
//  GFUserInfoItemView.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import UIKit

class GFUserInfoItemView: UIView {
    
    init() {
        super.init(frame: .zero)        
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var imageView = UIImageView()
    private var bodyLabel = GFTitleLabel(titleTextAlignment: .left, titleTextColor: .label, titleFontSize: 16)
    private var countLabel = GFTitleLabel(titleTextAlignment: .center, titleTextColor: .label, titleFontSize: 16)
    
    
    private func configureView() {
        addSubview(imageView)
        addSubview(bodyLabel)
        addSubview(countLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            bodyLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    func setUpInfoItem(using type: UserInfoTypes, with count: Int) {
        
        switch type {
        case .repos:
            imageView.image = UIImage(systemName: "folder")
            bodyLabel.text = "Public Repos"
        case .followers:
            imageView.image = UIImage(systemName: "heart")
            bodyLabel.text = "Followers"
        case .following:
            imageView.image = UIImage(systemName: "person.2")
            bodyLabel.text = "Following"
        case .gists:
            imageView.image = UIImage(systemName: "text.alignleft")
            bodyLabel.text = "Public Gists"
        }
        countLabel.text = String(count)
    }
    
}
