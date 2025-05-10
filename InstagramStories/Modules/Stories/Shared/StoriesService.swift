//
//  StoriesService.swift
//  InstagramStories
//
//  Created by Nikita Zaitsev on 10/05/2025.
//

protocol StoriesService: AnyObject {
    func fetchNextPage() -> [Story]
}
