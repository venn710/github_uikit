//
//  GFUserInfoHeaderVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    var userDetails: User!
    
    let hStackView = UIStackView()
    let vStackView = UIStackView()
    let userNameLabel = GFTitleLabel(
        titleTextAlignment: .center, titleTextColor: .label, titleFontSize: 26)
    let nameLabel = GFTitleLabel(
        titleTextAlignment: .center, titleTextColor: .secondaryLabel, titleFontSize: 14)
    let locationLabel = GFTitleLabel(
        titleTextAlignment: .center, titleTextColor: .secondaryLabel, titleFontSize: 18)
    let bioLabel = GFBodyLabel(bodyTextAlignment: .left, bodyTextColor: .secondaryLabel)
    
    init(userDetails: User!) {
        self.userDetails = userDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(hStackView, bioLabel)
        configureHStackLayout()
        configureBioLabel()
    }
    
    private func configureHStackLayout() {
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 20
        hStackView.alignment = .top
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        let imageView = GFAvatarImageView(frame: .zero)
        Task {
            await imageView.downloadImage(from: userDetails.avatarUrl)
        }
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        hStackView.addArrangedSubview(imageView)
        configureVStackLayout()
        hStackView.addArrangedSubview(vStackView)
    }
    
    private func configureVStackLayout() {
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 4
        vStackView.alignment = .leading
        
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
    }
    
    private func configureBioLabel() {
        bioLabel.text = userDetails.bio?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "No bio available"
        bioLabel.numberOfLines = 3
        bioLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
