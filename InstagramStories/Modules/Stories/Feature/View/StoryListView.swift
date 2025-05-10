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
    @StateObject private var viewModel: StoryViewModel
    private let commandFactory: StoryCommandFactory

    init(dataManager: StoryDataManager, commandFactory: StoryCommandFactory) {
        _viewModel = StateObject(wrappedValue: StoryViewModel(storiesService: StoriesServiceImp(dataManager: dataManager)))
        self.commandFactory = commandFactory
    }

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Constants.spacing) {
                    ForEach(viewModel.stories) { story in
                        NavigationLink(destination: StoryView(story: story, commandFactory: commandFactory)) {
                            StoryThumbnailView(story: story, isSeen: story.isSeen)
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
}
