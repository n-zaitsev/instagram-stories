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
    var isSeen: Bool
    var isLiked: Bool

    init(id: Int, isSeen: Bool = false, isLiked: Bool = false) {
        self.id = id
        self.isSeen = isSeen
        self.isLiked = isLiked
    }
}
