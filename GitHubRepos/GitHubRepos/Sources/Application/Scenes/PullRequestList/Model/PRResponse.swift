//
//  PRResponse.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/31/22.
//

import Foundation

struct PullResquest: Codable {
    let title: String?
    let user: User
    let body: String?
    let dateCreated: String?

}

struct User: Codable {
    let username: String?
    let authorImageUrl: String?
}

private extension PullResquest {
    enum CodingKeys: String, CodingKey {
        case title, user, body
        case dateCreated = "created_at"
    }
}

private extension User {
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case authorImageUrl = "avatar_url"
    }
}
