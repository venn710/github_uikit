//
//  SeachVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 31/03/24.
//

import UIKit

class SeachVC: UIViewController {
    
    let imageView = UIImageView()
    let userNameTextField = GFTextField()
    let gfButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureImageView()
        configureTextFieldView()
        configureButtonView()
        configureOnTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    func configureImageView() {
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 100),
                imageView.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    func configureTextFieldView() {
        
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        NSLayoutConstraint
            .activate(
                [
                    userNameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
                    userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                    userNameTextField.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    func configureButtonView() {
        
        view.addSubview(gfButton)
        NSLayoutConstraint
            .activate(
                [
                    gfButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
                    gfButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                    gfButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                    gfButton.heightAnchor.constraint(equalToConstant: 40)
                ])
    } 
    
    func configureOnTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(
            target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
        
    }
}


extension SeachVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
