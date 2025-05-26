//
//  APIService.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

protocol APIService {
    func getUserData(username: String, completion: @escaping (Result<GithubUser, NetworkError>) -> ())
}
