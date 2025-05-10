//
//  StoryCommandFactoryImp.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

struct StoryCommandFactoryImp: StoryCommandFactory {
    private let dataManager: StoryDataManager

    init(dataManager: StoryDataManager) {
        self.dataManager = dataManager
    }

    func markAsSeen(id: Int) {
        dataManager.markAsSeen(id: id)
    }

    func markAsLiked(id: Int, liked: Bool) {
        dataManager.markAsLiked(id: id, liked: liked)
    }
}
