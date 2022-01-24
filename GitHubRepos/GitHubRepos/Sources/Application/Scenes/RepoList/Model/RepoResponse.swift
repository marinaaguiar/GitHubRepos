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
    let repoDescription: String
    let forksCount: Int
    let starsCount: Int
    let authorImage: String
}

private extension Item {
    enum CodingKeys: String, CodingKey {
        case repoTitle = "name"
        case repoDescription = "description"
        case forksCount = "forks"
        case starsCount = "stargazers_count"
        case authorImage = "avatar_url"
    }
}

