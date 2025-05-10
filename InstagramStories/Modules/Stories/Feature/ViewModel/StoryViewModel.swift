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
        setupObservers()
    }

    deinit {
        removeObservers()
    }

    func loadNextPage() {
        let newStories = storiesService.fetchNextPage()

        guard !newStories.isEmpty else { return }

        stories.append(contentsOf: newStories)
    }

    private func setupObservers() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(handleStoryStateChanged(_:)),
                name: .storyStateDidChange,
                object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func handleStoryStateChanged(_ notification: Notification) {
        guard let story = notification.object as? Story else {
            return
        }

        if let idx = stories.firstIndex(where: { $0.id == story.id }) {
            stories[idx] = story
        }
    }
}
