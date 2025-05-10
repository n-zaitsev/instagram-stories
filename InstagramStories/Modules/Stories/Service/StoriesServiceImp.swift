//
//  StoriesServiceImp.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation

private enum Constants {
    static let resource = "users"
    static let `extension` = "json"
}

final class StoriesServiceImp: StoriesService {
    private var currentPageIndex = 0
    private var hasMore: Bool = true

    func fetchNextPage() -> [Story] {
        guard hasMore, let decodedPageRoot else { return [] }

        guard let page = decodedPageRoot.pages.first(where: { $0.page == currentPageIndex }) else {
            hasMore = false
            return []
        }

        currentPageIndex = currentPageIndex + 1
        hasMore = page.hasMore

        return page.users.compactMap { user -> Story? in
            guard let url = URL(string: user.profilePrictureURL) else { return nil }

            return Story(id: user.id, userName: user.name, imageURL: url)
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
