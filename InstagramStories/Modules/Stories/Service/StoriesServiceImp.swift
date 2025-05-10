//
//  StoriesServiceImp.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation



final class StoriesServiceImp: StoriesService {
    private let dataManager: StoryDataManager
    private var currentPageIndex = 0
    private var hasMore: Bool = true
    private var offset: Int = 0

    init(dataManager: StoryDataManager) {
        self.dataManager = dataManager
        StoriesSyncManager(dataManager: dataManager).sync()
    }

    func fetchNextPage() -> [Story] {
        offset += 10
        return dataManager.fetchStories(with: offset)
    }
}
