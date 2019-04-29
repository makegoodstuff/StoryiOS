//
//  Story.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

public protocol StoryListener: class {
    func storyDidEnd(with rating: StoryRating?)
}

public protocol StoryBuildable: Buildable {
    func build(withListener listener: StoryListener) -> ViewableRouting
}

public protocol Story {
    var id: String { get }
    var name: String { get }
    var pages: Int { get }
    var builder: StoryBuildable { get }
}
