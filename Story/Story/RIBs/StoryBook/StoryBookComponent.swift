//
//  StoryBookComponent.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import Foundation
import RIBs

protocol StoryBookDependency: Dependency {
    var userName: String { get }
    var mutableStoryStream: MutableStoryStream { get }
}

final class StoryBookComponent: Component<StoryBookDependency> {
    fileprivate var userName: String { return dependency.userName }

    fileprivate var mutableScoreStream: MutableStoryStream {
        return dependency.mutableStoryStream
    }
}
