//
//  StoryListView.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import Foundation
import SwiftUI
import SwiftData

private enum Constants {
    static let spacing: CGFloat = 16
    static let navigationTitle = "Stories"
}

struct StoryListView: View {
    @StateObject private var viewModel = StoryViewModel(storiesService: StoriesServiceImp())
    @Environment(\.modelContext) private var modelContext
    @Query private var states: [StoryState]

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Constants.spacing) {
                    ForEach(viewModel.stories) { story in
                        NavigationLink(destination: StoryView(story: story)) {
                            StoryThumbnailView(story: story, isSeen: isSeen(story.id))
                                .onAppear {
                                    if story.id == viewModel.stories.last?.id {
                                        viewModel.loadNextPage()
                                    }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle(Constants.navigationTitle)
        }
    }

    private func isSeen(_ id: Int) -> Bool {
        states.first(where: { $0.id == id })?.isSeen ?? false
    }
}

#Preview() {
    StoryListView()
}
