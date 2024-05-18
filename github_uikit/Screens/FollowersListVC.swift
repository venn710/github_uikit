//
//  FollowersListVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 10/04/24.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var userName: String
    init(userName: String) {
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = userName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            let response: Result<[Follower], ApiError> = await NetworkManager.shared.makeAPICall(apiCall: ApiEndPoints.getFollowers(userName: userName, page: 0))
            switch response {
            case .success(let success):
                print("successs is \(success)")
            case .failure(let failure):
                presentAlertOnMainThread(
                    alertTitle: "Uh-oh!", alertMessage: failure.rawValue, buttonTitle: "Okay")
            }
        }
        
    }
}
