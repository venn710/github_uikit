//
//  GFAlertVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 10/04/24.
//

import UIKit

class GFAlertVC: UIViewController {
    
    var alertTitle: String
    var alertDescription: String
    var buttonText: String
    
    let titleLabel = GFTitleLabel(titleTextAlignment: .center, titleTextColor: .label, titleFontSize: 20)
    let bodyLabel = GFBodyLabel(bodyTextAlignment: .center, bodyTextColor: .label)
    let actionButtonView = GFButton(backgroundColor: .systemPink, title: "Ok")
    let containerView = GFAlertContainerView()
    
    init(alertTitle: String, alertDescription: String, buttonText: String) {
        self.alertTitle = alertTitle
        self.alertDescription = alertDescription
        self.buttonText = buttonText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubViews(containerView, titleLabel, bodyLabel, actionButtonView)
        
        configureAlertView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    private func configureAlertView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.size.width * 0.9)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle
        titleLabel.numberOfLines = 10
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureBodyLabel() {
        bodyLabel.text = alertDescription
        bodyLabel.numberOfLines = 10
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButtonView.topAnchor, constant: -20),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureActionButton() {
        actionButtonView.setTitle(buttonText, for: .normal)
        actionButtonView.addTarget(self, action: #selector(popAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButtonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            actionButtonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func popAlert() {
        dismiss(animated: true)
    }
}
