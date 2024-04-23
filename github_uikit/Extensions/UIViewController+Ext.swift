//
//  UIViewController+Ext.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 23/04/24.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(alertTitle: String, alertMessage: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, alertDescription: alertMessage, buttonText: buttonTitle)
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
}
