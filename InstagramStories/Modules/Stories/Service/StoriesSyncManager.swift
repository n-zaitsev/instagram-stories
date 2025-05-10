//
//  StoriesSyncManager.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation

private enum Constants {
    static let resource = "users"
    static let `extension` = "json"
}

struct StoriesSyncManager {
    private let dataManager: StoryDataManager

    init(dataManager: StoryDataManager) {
        self.dataManager = dataManager
    }

    func sync() {
        guard dataManager.hasStories == false else { return }

        guard let decodedPageRoot else { return }

        for page in decodedPageRoot.pages {
            let stories = page.users.compactMap { user -> Story? in
                guard let url = URL(string: user.profilePrictureURL) else { return nil }

                return Story(
                    id: UUID().hashValue,
                    userId: user.id,
                    userName: user.name,
                    imageURL: url,
                    isSeen: false,
                    isLiked: false
                )
            }
            dataManager.insertStories(stories: stories)
        }
    }

    private var decodedPageRoot: PagesRoot? {
        guard let url = Bundle.main.url(forResource: Constants.resource, withExtension: Constants.extension),
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }

        return try? JSONDecoder().decode(PagesRoot.self, from: data)
    }
}
