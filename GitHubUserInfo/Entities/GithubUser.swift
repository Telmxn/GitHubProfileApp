//
//  GithubUser.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

struct GithubUser: Decodable {
    let avatar_url: String
    let name: String?
    let public_repos: Int
    let followers: Int
    let following: Int
}
