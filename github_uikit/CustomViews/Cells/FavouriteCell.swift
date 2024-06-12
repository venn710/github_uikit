//
//  FavouriteCell.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 12/06/24.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    static let reUseId: String = "FavouriteCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(titleTextAlignment: .left, titleTextColor: .secondaryLabel, titleFontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        accessoryType = .disclosureIndicator
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    func set(favourite: Follower) {
        userNameLabel.text = favourite.login
        Task {
            await avatarImageView.downloadImage(from: favourite.avatarUrl)
        }
    }
}
