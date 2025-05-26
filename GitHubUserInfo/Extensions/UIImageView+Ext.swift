//
//  UIImageView+Ext.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadSetImage(url: String) {
        let url = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, options: [.memoryCacheExpiration(.never)])
    }
}
