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
    
    init(alertTitle: String, alertDescription: String, buttonText: String) {
        
        self.alertTitle = alertTitle
        self.alertDescription = alertDescription
        self.buttonText = buttonText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel = GFTitleLabel(titleTextAlignment: .center, titleTextColor: .label, titleFontSize: 20)
    let bodyLabel = GFBodyLabel(bodyTextAlignment: .center, bodyTextColor: .label)
    let actionButtonView = GFButton(backgroundColor: .systemPink, title: "Ok")
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureAlertView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()

    }
    
    private func configureAlertView() {
        
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.widthAnchor.constraint(
                    equalToConstant: UIScreen.main.bounds.size.width * 0.9)
            ])
    }
    
    private func configureTitleLabel() {
        
        titleLabel.text = alertTitle
        titleLabel.numberOfLines = 10
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate(
            [
                
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
            ])
        
    }
    
    private func configureBodyLabel() {
        
        bodyLabel.text = alertDescription
        bodyLabel.numberOfLines = 10
        containerView.addSubview(bodyLabel)
        
        NSLayoutConstraint.activate(
            [
                bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                bodyLabel.bottomAnchor.constraint(equalTo: actionButtonView.topAnchor, constant: -20),
                bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
            ])
    }
    
    private func configureActionButton() {
        
        containerView.addSubview(actionButtonView)
        actionButtonView.setTitle(buttonText, for: .normal)
        
        actionButtonView.addTarget(self, action: #selector(popAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate(
            [
                actionButtonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
                actionButtonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
                actionButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
            ])
    }
    
    @objc func popAlert() {
        
        /// This was not working check why { navigationController?.dismiss(animated: true) }
        dismiss(animated: true)
    }
}
