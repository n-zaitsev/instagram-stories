//
//  PagesRoot.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation

struct PagesRoot: Codable {
    let pages: [Pages]
}

struct Pages: Codable {
    let users: [UserDTO]
    let page: Int
    let hasMore: Bool
}

struct UserDTO: Codable {
    let id: Int
    let name: String
    let profilePrictureURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePrictureURL = "profile_picture_url"
    }
}
