//
//  NetworkServiceManager.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

class NetworkServiceManager {
    
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func getUserData(username: String, completion: @escaping (Result<GithubUser, NetworkError>) -> ()) {
        service.getUserData(username: username, completion: completion)
    }
}
