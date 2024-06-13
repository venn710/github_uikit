//
//  GFAvatarImageView.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 17/05/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 12
        clipsToBounds = true
        image = GFImages.avatarPlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) async {
        
        if let imageCache = NetworkManager.shared.imageCache.object(forKey: NSString(string: urlString)) {
            image = imageCache
            return
        }
        let imageData: Data? = await NetworkManager.shared.downloadImage(from: urlString)
        guard let imageData,
              let uiImage = UIImage(data: imageData) else { return }
        
        NetworkManager.shared.imageCache.setObject(uiImage, forKey: NSString(string: urlString))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            image = UIImage(data: imageData)
        }
    }
}
