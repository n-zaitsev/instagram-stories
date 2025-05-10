//
//  Story.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation

struct Story: Identifiable, Codable {
    let id: Int
    let userName: String
    let imageURL: URL
}
