//
//  GFWebViewVC.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 03/06/24.
//

import UIKit
import WebKit

class GFWebViewVC: UIViewController {
    
    var url: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureWebView() {
        guard let url = URL(string: url) else { return }
        let webView = WKWebView()
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
        /*
         To learn more about frame and bounds head over to this.
         https://www.hackingwithswift.com/example-code/uikit/whats-the-difference-between-frame-and-bounds
         */
        webView.frame = view.bounds
        webView.translatesAutoresizingMaskIntoConstraints = false
    }
}
