//
//  HomeViewModel.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

protocol HomeDelegate {
    func render(_ state: HomeState)
}

enum HomeState {
    case loading
    case loaded(GithubUser)
    case error(NetworkError)
}

class HomeViewModel {
    
    private let networkServiceManager = DependencyContainer.shared.networkServiceManager
    
    private let inputData: HomeInputData
    
    private var delegate: HomeDelegate?
    
    init(inputData: HomeInputData) {
        self.inputData = inputData
    }
    
    func subscribe(_ delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func fetchData(username: String?) {
        delegate?.render(.loading)
        var inputUsername = inputData.username
        if let username = username {
            inputUsername = username
        }
        networkServiceManager.getUserData(username: inputUsername) { [weak self] result in
            switch result {
            case .success(let success):
                self?.delegate?.render(.loaded(success))
            case .failure(let failure):
                self?.delegate?.render(.error(failure))
            }
        }
    }
}
