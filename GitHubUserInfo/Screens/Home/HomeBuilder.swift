//
//  HomeBuilder.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

class HomeBuilder {
    private let inputData: HomeInputData
    
    init(inputData: HomeInputData) {
        self.inputData = inputData
    }
    
    func build() -> HomeViewController {
        let viewModel = HomeViewModel(inputData: inputData)
        return HomeViewController(viewModel: viewModel)
    }
}
