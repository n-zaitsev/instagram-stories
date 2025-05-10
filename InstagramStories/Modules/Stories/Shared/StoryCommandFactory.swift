//
//  StoryCommandFactory.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

protocol StoryCommandFactory {
    func markAsSeen(id: Int)
    func markAsLiked(id: Int, liked: Bool)
}
