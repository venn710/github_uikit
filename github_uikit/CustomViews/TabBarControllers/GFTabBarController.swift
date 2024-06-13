//
//  GFTabBarController.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 12/06/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = .systemBackground
        viewControllers = [buildSearchVC(), buildFavouritesVC()]
    }
    
    private func buildSearchVC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchVC.title = "Search"
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func buildFavouritesVC() -> UINavigationController {
        let favouritesVC = FavoritesVC()
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favouritesVC.title = "Favourites"
        return UINavigationController(rootViewController: favouritesVC)
    }
}
