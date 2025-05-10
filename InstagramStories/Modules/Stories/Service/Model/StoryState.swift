//
//  StoryState.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation
import SwiftData

@Model
final class StoryState {
    @Attribute(.unique) var id: Int
    var userId: Int
    var userName: String
    var imageURL: String
    var isSeen: Bool
    var isLiked: Bool
    var isSyncronised: Bool

    init(id: Int, userId: Int, userName: String, imageURL: String, isSeen: Bool, isLiked: Bool, isSyncronised: Bool) {
        self.id = id
        self.userId = userId
        self.userName = userName
        self.imageURL = imageURL
        self.isSeen = isSeen
        self.isLiked = isLiked
        self.isSyncronised = isSyncronised
    }
}
