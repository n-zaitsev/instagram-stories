//
//  StoryViewModel.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation
import Combine

final class StoryViewModel: ObservableObject {
    @Published private(set) var stories: [Story] = []
    private let storiesService: StoriesService

    init(storiesService: StoriesService) {
        self.storiesService = storiesService
        self.stories = storiesService.fetchNextPage()
    }

    func loadNextPage() {
        let newStories = storiesService.fetchNextPage()

        guard !newStories.isEmpty else { return }

        stories.append(contentsOf: newStories)
    }
}
