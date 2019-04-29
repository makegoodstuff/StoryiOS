//
//  RandomStoryAdapter.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

class RandomStoryAdapter: Story, StoryBuildable, RandomStoryListener {
    let id = "randomstory"
    let name = "Random Story"
    var builder: StoryBuildable { return self }

    private let randomStoryBuilder: RandomStoryBuilder
    private weak var listener: StoryListener?

    init(dependency: RandomStoryDependency) {
        randomStoryBuilder = RandomStoryBuilder(dependency: dependency)
    }

    func build(withListener listener: StoryListener) -> ViewableRouting {
        self.listener = listener
        return randomStoryBuilder.build(withListener: self)
    }

    func didRandomlyEnd(with rating: StoryRating) {
        listener?.storyDidEnd(with: rating)
    }
}
