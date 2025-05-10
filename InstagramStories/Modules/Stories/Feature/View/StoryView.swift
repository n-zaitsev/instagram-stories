//
//  ContentView.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import SwiftUI
import SwiftData
import Kingfisher

struct StoryView: View {
    let story: Story
    private let commandFactory: StoryCommandFactory

    init(story: Story, commandFactory: StoryCommandFactory) {
        self.story = story
        self.commandFactory = commandFactory
    }

    var body: some View {
            KFImage(story.imageURL)
                .placeholder({
                    Color.black
                        .overlay(
                            Image(systemName: "xmark.octagon")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        )
                })
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .onAppear { commandFactory.markAsSeen(id: story.id) }

        HStack {
            Spacer()
            Button(action: { commandFactory.markAsLiked(id: story.id, liked: !story.isLiked) }) {
                Image(systemName: story.isLiked ? "heart.fill" : "heart")
                    .font(.largeTitle)
            }
        }
    }
}
