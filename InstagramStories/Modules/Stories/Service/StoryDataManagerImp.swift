//
//  StoryDataManagerImp.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation
import SwiftData
import SwiftUI

private enum Constants {
    static let fetchLimit = 10
}

final class StoryDataManagerImp: StoryDataManager {
    private let modelContext: ModelContext
    private var states: [StoryState] = []

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func insertStories(stories: [Story]) {
        for story in stories {
            modelContext.insert(StoryState(dto: story))
        }
        saveContext()
    }

    var hasStories: Bool {
        var fetchDescriptor = FetchDescriptor<StoryState>()
        fetchDescriptor.fetchLimit = 1

        guard let stories = try? modelContext.fetch(fetchDescriptor) else {
            assert(false, "Fetch error")
            return false
        }

        return !stories.isEmpty
    }

    func fetchStories(with offset: Int) -> [Story] {
        var fetchDescriptor = fetchDescriptor
        fetchDescriptor.fetchOffset = offset

        guard let stories = try? modelContext.fetch(fetchDescriptor) else {
            assert(false, "Fetch error")
            return []
        }
        
        return stories.compactMap { Story(businessObject: $0) }
    }

    private var fetchDescriptor: FetchDescriptor<StoryState> {
        var fetchDescriptor = FetchDescriptor<StoryState>()
        fetchDescriptor.fetchLimit = Constants.fetchLimit

        return fetchDescriptor
    }

    private var updateFetchDescriptor: FetchDescriptor<StoryState> {
        var fetchDescriptor = FetchDescriptor<StoryState>()
        fetchDescriptor.fetchLimit = 1

        return fetchDescriptor
    }

    func markAsSeen(id: Int) {
        var fetchDescriptor = updateFetchDescriptor
        fetchDescriptor.predicate = #Predicate { $0.id == id }

        guard let object = try? modelContext.fetch(fetchDescriptor).first else {
            assert(false, "Fetch error")
            return
        }

        object.isSeen = true
        object.isSyncronised = false
        saveContext()
        postNotificationObjectDidChange(object: object)
    }

    func markAsLiked(id: Int, liked: Bool) {
        var fetchDescriptor = updateFetchDescriptor
        fetchDescriptor.predicate = #Predicate { $0.id == id }

        guard let object = try? modelContext.fetch(fetchDescriptor).first else {
            assert(false, "Fetch error")
            return
        }

        object.isLiked = liked
        object.isSyncronised = false
        saveContext()
        postNotificationObjectDidChange(object: object)
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    private func postNotificationObjectDidChange(object: StoryState) {
        NotificationCenter.default.post(
            name: .storyStateDidChange,
            object: Story(businessObject: object)
        )
    }
}

private extension Story {
    init?(businessObject: StoryState) {
        guard let url = URL(string: businessObject.imageURL) else { return nil }

        self.init(
            id: businessObject.id,
            userId: businessObject.userId,
            userName: businessObject.userName,
            imageURL: url,
            isSeen: businessObject.isSeen,
            isLiked: businessObject.isLiked
        )
    }
}

private extension StoryState {
    convenience init(dto: Story) {
        self.init(
            id: dto.id,
            userId: dto.userId,
            userName: dto.userName,
            imageURL: dto.imageURL.absoluteString,
            isSeen: dto.isSeen,
            isLiked: dto.isLiked,
            isSyncronised: true
        )
    }
}

extension Notification.Name {
    static let storyStateDidChange = Notification.Name("storyStateDidChange")
}
