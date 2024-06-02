//
//  GFUserInfoHeaderVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    var userDetails: User!
    init(userDetails: User!) {
        self.userDetails = userDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    private func layoutViews() {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 20
        hStackView.alignment = .top
        
        view.addSubview(hStackView)
        
        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
        
        let imageView = GFAvatarImageView(frame: .zero)
        Task {
            await imageView.downloadImage(from: userDetails.avatarUrl)
        }
        
        hStackView.addArrangedSubview(imageView)
        
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.spacing = 8
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.alignment = .leading
        
        let userNameLabel = GFTitleLabel(
            titleTextAlignment: .center, titleTextColor: .black, titleFontSize: 26)
        let nameLabel = GFTitleLabel(
            titleTextAlignment: .center, titleTextColor: .systemGray3, titleFontSize: 14)
        let locationLabel = GFTitleLabel(
            titleTextAlignment: .center, titleTextColor: .systemGray3, titleFontSize: 16)
    
        
        userNameLabel.text = userDetails.login
        nameLabel.text = userDetails.name
        locationLabel.text = userDetails.location
        
        vStackView.addArrangedSubview(userNameLabel)
        if userDetails.name != nil {
            vStackView.addArrangedSubview(nameLabel)
        }
        if userDetails.location != nil{
            vStackView.addArrangedSubview(locationLabel)
        }
        
        hStackView.addArrangedSubview(vStackView)
        
        let bioLabel = GFTitleLabel(
            titleTextAlignment: .left, titleTextColor: .systemGray4, titleFontSize: 18)
        bioLabel.text = userDetails.bio
        bioLabel.numberOfLines = 5
    
        
        if userDetails.bio != nil {
            view.addSubview(bioLabel)
        }
            
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        if userDetails.bio != nil {
            NSLayoutConstraint.activate([
                bioLabel.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 20),
                bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
    }
}
