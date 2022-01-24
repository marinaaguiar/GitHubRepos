//
//  RepoResponse.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import Foundation

struct RepoResponse: Codable {
    let items: [Item]
}

struct Item: Codable {
    let repoTitle: String
    let owner: [Owner]
    let repoDescription: String
    let forksCount: Int
    let starsCount: Int
}

struct Owner: Codable {
    let username: String
    let authorImageUrl: String
}

private extension Item {
    enum CodingKeys: String, CodingKey {
        case repoTitle = "name"
        case owner
        case repoDescription = "description"
        case forksCount = "forks"
        case starsCount = "stargazers_count"
    }
}

private extension Owner {
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case authorImageUrl = "avatar_url"
        
    }
}

