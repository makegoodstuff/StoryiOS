//
//  StoryAdapter.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

class StoryAdapter: Story, StoryBuildable, StoryListener {
    let id = "story"
    let name = "Story"
    let storyBuilder: StoryBuilder
    var builder: StoryBuildable { return self }
    weak var storyListener: StoryListener?

    init(dependency: StoryDependency) {
        storyBuilder = StoryBuilder(dependency: dependency)
    }

    func build(withListener listener: StoryListener) -> ViewableRouting {
        storyListener = listener
        return storyBuilder.build(withListener: self)
    }

    func storyDidEnd(with rating: StoryRating?) {
        storyListener?.storyDidEnd(with: rating)
    }
}
