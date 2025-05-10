//
//  StoryThumbnailView.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

import SwiftUI
import Kingfisher

private enum Constants {
    static let gradient = Gradient(colors: [Color.red, Color.orange, Color.purple, Color.red])
    static let imageSize: CGFloat = 80
    static let ringSize: CGFloat = 88
    static let lineWidth: CGFloat = 3
}

struct StoryThumbnailView: View {
    let story: Story
    let isSeen: Bool

    var body: some View {
        ZStack {
            avatarImage
            storyRing
        }
    }

    @ViewBuilder
    private var avatarImage: some View {
        KFImage(story.imageURL)
            .placeholder({
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .foregroundColor(.gray)
            })
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .clipShape(Circle())
    }
    
    @ViewBuilder
    private var storyRing: some View {
        let gradient = isSeen ? AngularGradient(colors: [Color.gray], center: .center) : AngularGradient(gradient: Constants.gradient, center: .center)
        
        Circle()
            .strokeBorder(gradient, lineWidth: Constants.lineWidth)
            .frame(width: Constants.ringSize, height: Constants.ringSize)
    }
}
