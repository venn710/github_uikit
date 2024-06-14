//
//  FavoritesVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 31/03/24.
//

import UIKit

class FavoritesVC: UIViewController {
    
    let uiTableView: UITableView = UITableView()
    var favourites: [Follower] = []
    
    var uiTableViewDataSource: UITableViewDiffableDataSource<Section, Follower>?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
//      configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavourites()
    }

    private func configureVC() {
        title = "Favourites"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(uiTableView)
        uiTableView.translatesAutoresizingMaskIntoConstraints = false
        uiTableView.frame = view.bounds
        uiTableView.rowHeight = 100
        uiTableView.delegate = self
        
        uiTableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reUseId)
        
        // Method: 2 for setting dataSource
        uiTableView.dataSource = self
    }
    
//    private func configureDataSource() {
//        uiTableViewDataSource = UITableViewDiffableDataSource(
//            tableView: uiTableView) { tableView, indexPath, itemIdentifier in
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reUseId) as? FavouriteCell else { return nil }
//                cell.set(favourite: itemIdentifier)
//                return cell
//            }
//    }
    
    private func getFavourites() {
        let response = PersistentManager.shared.retrieve()
        switch response {
        case .success(let success):
            if success.isEmpty {
                showEmptyStateView(with: "No Favourites?\nAdd one on the follower screen.")
            } else {
                favourites = success
//                updateTableView()
                
                // Method 2: for updating the data in tableView
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    uiTableView.reloadData()
                    view.bringSubviewToFront(uiTableView)
                }
            }

        case .failure(let failure):
            presentAlertOnMainThread(
                alertTitle: "Something went wrong",
                alertMessage: failure.rawValue,
                buttonTitle: "OK"
            )
        }
    }
    
//    private func updateTableView() {
//        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
//        snapShot.appendSections([.main])
//        snapShot.appendItems(favourites)
//        uiTableViewDataSource?.apply(snapShot, animatingDifferences: true)
//    }
}

extension FavoritesVC {
    enum Section {
        case main
    }
}

// MARK: - Method 2 for dataSource
extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reUseId) as? FavouriteCell else {
            return UITableViewCell()
        }
        cell.set(favourite: favourites[indexPath.row])
        return cell
    }
}

// MARK: - Delegate for handling events on tableView
extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favouritedUser = favourites[indexPath.row]
        let followerListVC = FollowersListVC(userName: favouritedUser.login)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        let favouritedUser = favourites[indexPath.row]
        
        let error = PersistentManager.shared.modify(
            favourite: favouritedUser,
            type: .delete
        )
        if let error {
            presentAlertOnMainThread(
                alertTitle: "Something went wrong",
                alertMessage: error.rawValue,
                buttonTitle: "OK"
            )
        } else {
            favourites.remove(at: indexPath.row)
            uiTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
