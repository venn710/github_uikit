//
//  UserDetailsVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 26/05/24.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    let follower: Follower!
    weak var delegate: UserDetailsVCDelegate?
    
    private var headerView = UIView()
    private var itemInfoView1 = UIView()
    private var itemInfoView2 = UIView()
    private var dateLabel = GFBodyLabel(bodyTextAlignment: .center)
    
    private var uiScrollView = UIScrollView()
    private var contentView = UIView()
    
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
        configureScrollView()
        getUserDetails()
        layoutUI()
        configureDoneButton()
    }
    
    private func configureScrollView() {
        view.addSubview(uiScrollView)
        uiScrollView.addSubview(contentView)
        uiScrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: uiScrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 650)
        ])
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
                configureChildVCs(with: success)
                
            case .failure(let failure):
                presentAlertOnMainThread(alertTitle: "Uh-Oh!", alertMessage: failure.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func add(childVC: UIViewController, to view: UIView) {
        view.addSubview(childVC.view)
        addChild(childVC)
        childVC.view.frame = view.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func layoutUI() {
        
        contentView.addSubViews(headerView, itemInfoView1, itemInfoView2, dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView1.translatesAutoresizingMaskIntoConstraints = false
        itemInfoView2.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: Double = 16
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            
            itemInfoView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            itemInfoView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemInfoView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemInfoView1.heightAnchor.constraint(equalToConstant: 140),
            
            
            itemInfoView2.topAnchor.constraint(equalTo: itemInfoView1.bottomAnchor, constant: 12),
            itemInfoView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemInfoView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemInfoView2.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemInfoView2.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            
        ])
    }
    
    private func configureChildVCs(with user: User) {
        
        let userRepoInfoVC = GFUserRepoInfoVC(userDetails: user)
        let userFollowersInfoVC = GFUserFollowersInfoVC(userDetails: user)
        
        userRepoInfoVC.delegate = self
        userFollowersInfoVC.delegate = self
        
        add(childVC: GFUserInfoHeaderVC(userDetails: user), to: headerView)
        add(childVC: userRepoInfoVC, to: itemInfoView1)
        add(childVC: userFollowersInfoVC, to: itemInfoView2)
        dateLabel.text = "GitHub since \(user.createdAt.convertTo(from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "MMM yyyy"))"
    }
}

// MARK: - Handling tap on Github Profile.
extension UserDetailsVC: GFUserRepoInfoVCDelegate {
    func tapOnProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(
                alertTitle: "Invalid URL",
                alertMessage: "The url of this user is invalid, please check",
                buttonTitle: "OK"
            )
            return
        }
        openInSafariVC(with: url)
    }
}

// MARK: - Handling tap on Get Followers.
extension UserDetailsVC: GFUserFollowerInfoVCDelegate {
    func tapOnGetFollowers(for user: User) {
        
        guard user.followers > 0 else {
            presentAlertOnMainThread(alertTitle: "Oh No!", alertMessage: "This user doesn't have any followers", buttonTitle: "OK")
            return
        }
        delegate?.didRequestFollowers(for: user)
        dismissVC()
    }
}
