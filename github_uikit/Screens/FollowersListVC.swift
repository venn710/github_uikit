//
//  FollowersListVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 10/04/24.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var userName: String
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var pageCount: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    
    // To Prevent Race conditions when the network connection is slow.
    private var isLoadingMoreFollowers: Bool = false
    
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
    
    init(userName: String) {
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUICollectionView()
        configureDataSource()
        configureSearchBar()
        getFollowers()
        configureFavouritesButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = userName
    }
    
    private func configureFavouritesButton() {
        let uiButtonBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserToFavourites))
        navigationItem.rightBarButtonItem = uiButtonBarItem
    }
    
    @objc func addUserToFavourites() {
        
        Task {
            let userData: Result<User, ApiError> = await NetworkManager.shared.makeAPICall(apiCall: ApiEndPoints.getUserData(login: userName))
            
            switch userData {
            case .success(let success):
                let error = PersistentManager.shared.modify(
                        favourite: Follower(
                            login: success.login,
                            avatarUrl: success.avatarUrl
                        ),
                        type: .add
                    )
                if let error {
                    presentAlertOnMainThread(
                        alertTitle: "Something went wrong",
                        alertMessage: error.rawValue,
                        buttonTitle: "OK"
                    )
                    return
                }
                presentAlertOnMainThread(
                    alertTitle: "Success!",
                    alertMessage: "You have successfully favourited this user",
                    buttonTitle: "Hooray!!"
                )

            case .failure(let failure):
                presentAlertOnMainThread(
                    alertTitle: "Something went wrong",
                    alertMessage: failure.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
    }
    
    /*
    Updating anything in the UI/Class that is marked as MainActor will make sure it runs on main thread.
     */
    
    private func getFollowers() {
        isLoadingMoreFollowers = true
        Task {
            showLoader()
//            try? await Task.sleep(for: .seconds(2))
            let response: Result<[Follower], ApiError> = await NetworkManager.shared.makeAPICall(apiCall: ApiEndPoints.getFollowers(userName: userName, page: pageCount))
            dismissLoader()
            
            isLoadingMoreFollowers = false
            switch response {
            case .success(let success):
                if success.count < 100 {
                    hasMoreFollowers = false
                }
                followers.append(contentsOf: success)
                
                if followers.isEmpty {
                    showEmptyStateView(with: "This user doesn't have any followers, Please follow kardo!")
                    return
                }
//                collectionView?.reloadData()
                updateCollectionView(with: followers)
            case .failure(let failure):
                presentAlertOnMainThread(
                    alertTitle: "Uh-oh!", alertMessage: failure.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    private func configureUICollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.configureCustomColumnCollectionViewLayout(
                in: view,
                with: 3
            )
        )
        collectionView?.delegate = self
//        collectionView?.dataSource = self
        
        guard let collectionView else { return }
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reUseId)
    }
    
    /// Method-1 to implement DataSource
    /// Manage data and provide cells for a collection view using UICollectionViewDiffableDataSource go to documentation for more details.
    /*
     To connect a diffable data source to a collection view, you create the diffable data source using its init(collectionView:cellProvider:) initializer, passing in the collection view you want to associate with that data source. You also pass in a cell provider, where you configure each of your cells to determine how to display your data in the UI.
     */
    private func configureDataSource() {
        guard let collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView){ collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowerCell.reUseId, for: indexPath) as? FollowerCell else { return nil }

            cell.set(follower: itemIdentifier)
            return cell
        }
    }
    
    private func updateCollectionView(with listOfFollowers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(listOfFollowers)
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
    
    private func configureSearchBar() {
        let searchBarController = UISearchController()
        searchBarController.searchResultsUpdater = self
        searchBarController.searchBar.placeholder = "Search for a username"
        searchBarController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
    }    
}

extension FollowersListVC {
    enum Section {
        case main
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    /*
     iPhone 15Pro
     SafeArea Height in top is 59 (54+5)
     SafeArea Height in bottom is 34
     Total ScreenSize including SafeArea is  852
     
     */
    /// Method-1 to implement Pagination
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let contentOffset: CGFloat = scrollView.contentOffset.y
//        let height: CGFloat = scrollView.bounds.height
//        let contentHeight: CGFloat = scrollView.contentSize.height
//        let navBarHeight: CGFloat = navigationController?.navigationBar.frame.size.height ?? .zero
//        print("values are \(contentOffset), \(height), \(contentHeight)")
//        
//        if contentOffset > (contentHeight - height)  {
//            guard hasMoreFollowers else { return }
//            pageCount += 1
//            getFollowers()
//        }
//    }
    
    /// Method-2 to implement Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
        if (indexPath.row == followers.count - 1) {
            pageCount += 1
            getFollowers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let followersList: [Follower] = isSearching ? filteredFollowers : followers
        let selectedFollower = followersList[indexPath.row]
        let userDetailsVC = UserDetailsVC(follower: selectedFollower)
        userDetailsVC.delegate = self
        present(UINavigationController(rootViewController: userDetailsVC), animated: true)
    }
}

///// Method-2 to implement DataSource
//extension FollowersListVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        followers.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reUseId, for: indexPath) as? FollowerCell
//        cell?.set(follower: followers[indexPath.row])
//        return cell ?? UICollectionViewCell()
//    }
//}

/// To implement the SearchBar Input functionality.
extension FollowersListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.isNotEmpty else {
            filteredFollowers.removeAll()
            isSearching = false
            updateCollectionView(with: followers)
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { _follower in
            _follower.login.lowercased().contains(searchText.lowercased())
        }
        updateCollectionView(with: filteredFollowers)
    }
}

extension FollowersListVC: UserDetailsVCDelegate {
    func didRequestFollowers(for user: User) {
        userName = user.login
        title = userName
        followers = []
        filteredFollowers = []
        pageCount = 1
        hasMoreFollowers = true
        isSearching = false
        
        navigationItem.searchController?.isActive = false
        
        getFollowers()
    }
}
