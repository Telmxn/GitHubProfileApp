//
//  DependencyContainer.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    lazy var networkServiceManager: NetworkServiceManager = {
        return NetworkServiceManager(service: URLSessionAdapter())
    }()
}
