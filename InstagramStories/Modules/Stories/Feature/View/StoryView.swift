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
    @Environment(\.modelContext) private var modelContext
    @Query private var states: [StoryState]
    @Environment(\.presentationMode) var mode
    @GestureState private var dragOffset: CGSize = .zero

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
                .onAppear { markSeen() }

        HStack {
            Spacer()
            Button(action: { toggleLike() }) {
                Image(systemName: isLiked() ? "heart.fill" : "heart")
                    .font(.largeTitle)
            }
        }
    }

    private func stateEntity() -> StoryState {
        if let existing = states.first(where: { $0.id == story.id }) {
            return existing
        }
        let newState = StoryState(id: story.id)
        modelContext.insert(newState)
        return newState
    }

    private func markSeen() {
        let entity = stateEntity()
        entity.isSeen = true
        saveContext()
    }

    private func toggleLike() {
        let entity = stateEntity()
        entity.isLiked.toggle()
        saveContext()
    }

    private func isLiked() -> Bool {
        stateEntity().isLiked
    }

    private func saveContext() {
            do {
                try modelContext.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
}

#Preview {
    StoryView(story: .init(id: 0, userName: "Name", imageURL: URL(string: "https://pixabay.com/photos/bird-eastern-towhee-towhee-nature-9551361/")!))
        .modelContainer(for: StoryState.self, inMemory: true)
}
