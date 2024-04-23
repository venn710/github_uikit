//
//  SearchVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 31/03/24.
//

import UIKit

class SearchVC: UIViewController {
    
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
        
        /// Kept here but not in viewDidLoad because viewDidLoad will call only once like if we push some othet screen and come back again then
        /// If we write this piece of code in viewDidLoad then navBar will come again because it was there in the new screen that was pushed so
        /// If we write this here then everytime this screen appears navBar will be hidden.
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
        gfButton.addTarget(self, action: #selector(pushFollowersList), for: .touchUpInside)
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


/// To handle the tap of the done/go or any return button in keyboard we need to give the delegate to that specific textfield and the delegate needs to be handled.
extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersList()
        return true
    }
    
}

extension SearchVC  {
    
    private var isUserNameEntered: Bool {
        
        guard let userName = userNameTextField.text else { return false }
        return userName.isNotEmpty
    }
    
    @objc func pushFollowersList() {
        
        guard isUserNameEntered else {
            
//            let gfAlertVC = GFAlertVC(alertTitle: "Title can be this long so that can be easily visible to the user", alertDescription: "Baby you light up my world like nobody else, the way that you flip your hair gets me overwhelmed, but when you smile at the ground it ain't hard to tell you don't know oh-oh, you don't know you're beatiful.", buttonText: "OKAYYYY")
//            
//            gfAlertVC.modalPresentationStyle = .overFullScreen
//            gfAlertVC.modalTransitionStyle = .crossDissolve
//            
//            navigationController?.present(gfAlertVC, animated: true)
////            present(gfAlertVC, animated: true)
            
            presentAlertOnMainThread(alertTitle: "Title can be this long so that can be easily visible to the user", alertMessage: "Baby you light up my world like nobody else, the way that you flip your hair gets me overwhelmed, but when you smile at the ground it ain't hard to tell you don't know oh-oh, you don't know you're beatiful.", buttonTitle: "OneDirection")
            
            return
        }
        
        let followersListVC = FollowersListVC()
        followersListVC.userName = userNameTextField.text
        followersListVC.title = userNameTextField.text
        
        navigationController?.pushViewController(followersListVC, animated: true)
    }
}
