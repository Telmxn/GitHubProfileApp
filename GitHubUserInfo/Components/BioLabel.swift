//
//  BioLabel.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import UIKit

class BioLabel: UILabel {
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textColor = .white
        font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        numberOfLines = 0
    }
}
