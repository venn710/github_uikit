//
//  UIViewController+Ext.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 23/04/24.
//

import UIKit

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
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoader() {
        loaderContainerView?.removeFromSuperview()
        loaderContainerView = nil
    }
    
    // FIXME: - Refactor this code.
    func showEmptyStateView(with title: String) {
        let titleLabel = GFTitleLabel(titleTextAlignment: .center, titleTextColor: .secondaryLabel, titleFontSize: 28)
        titleLabel.text = title
        titleLabel.numberOfLines = 3
        let imageLabel = UIImageView(image: UIImage(named: "empty-state-logo"))
        view.addSubview(titleLabel)
        view.addSubview(imageLabel)
        
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            imageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 150),
            imageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40)
        ])
    }
}
