//
//  GFUserInfoItemVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import UIKit

class GFUserInfoItemVC: UIViewController {

    var userDetails: User!
    
    init(userDetails: User) {
        self.userDetails = userDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewBackground()
        configureVC()
    }
    
    var userInfoItem1: GFUserInfoItemView = GFUserInfoItemView()
    var userInfoItem2: GFUserInfoItemView = GFUserInfoItemView()
    var buttonView = GFButton()
    
    
    private func configureViewBackground() {
        view.layer.cornerRadius = 24
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureVC() {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        view.addSubViews(stackView, buttonView)
        
        userInfoItem1.translatesAutoresizingMaskIntoConstraints = false
        userInfoItem2.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(userInfoItem1)
        stackView.addArrangedSubview(userInfoItem2)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
}
