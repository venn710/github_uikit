//
//  UserDetailsVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 26/05/24.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    let follower: Follower!
    
    init(follower: Follower!) {
        self.follower = follower
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDoneButton()
        getUserDetails()
    }
    
    private func configureDoneButton() {
        let uiBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = uiBarButton
    }
    
    private func getUserDetails() {
        Task {
            showLoader()
            let response: Result<User, ApiError> = await NetworkManager.shared.makeAPICall(apiCall: ApiEndPoints.getUserData(login: follower.login))
            dismissLoader()
            switch response {
            case .success(let success):
                add(childVC: GFUserInfoHeaderVC(userDetails: success), to: view)
                
            case .failure(let failure):
                presentAlertOnMainThread(alertTitle: "Uh-Oh!", alertMessage: failure.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func add(childVC: UIViewController, to view: UIView) {
        view.addSubview(childVC.view)
        addChild(childVC)
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
