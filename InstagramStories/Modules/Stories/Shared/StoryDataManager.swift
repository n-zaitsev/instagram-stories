//
//  StoryDataManager.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

protocol StoryDataManager: AnyObject {
    func fetchStories(with offset: Int) -> [Story]
    func insertStories(stories: [Story])
    func markAsSeen(id: Int)
    func markAsLiked(id: Int, liked: Bool)

    var hasStories: Bool { get }
}
