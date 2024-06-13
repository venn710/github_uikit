//
//  UIViewController+Ext.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 23/04/24.
//

import UIKit
import SafariServices

fileprivate var loaderContainerView: UIView!

extension UIViewController {
    
    func presentAlertOnMainThread(alertTitle: String, alertMessage: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, alertDescription: alertMessage, buttonText: buttonTitle)
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    /*
     Here we can refactor this and keep in a separate ViewController say LoadingVC and extend the classes which has the loading capability
     with LoadingVC, so that other non loading VC's will not have the capability to showLoaders and all.
     */
    func showLoader() {
        loaderContainerView = UIView(frame: view.bounds)
        guard let loaderContainerView else { return }
        view.addSubview(loaderContainerView)
        
        loaderContainerView.backgroundColor = .systemBackground
        loaderContainerView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            loaderContainerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loaderContainerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loaderContainerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loaderContainerView.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoader() {
        loaderContainerView?.removeFromSuperview()
        loaderContainerView = nil
    }
    
    func showEmptyStateView(with title: String) {
        let emptyStateView = GFEmptyStateView(message: title)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func openInSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
