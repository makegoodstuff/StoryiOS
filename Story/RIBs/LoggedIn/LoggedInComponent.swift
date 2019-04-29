//
//  LoggedInComponent.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import Foundation
import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {
    let userName: String

    fileprivate var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }

    fileprivate var stories: [Story] {
        return shared {
            return [RandomStoryAdapter(dependency: self), StoryAdapter(dependency: self)]
        }
    }

    var mutableStoryStream: MutableStoryStream {
        return shared { StoryStreamImpl() }
    }

    var storyStream: StoryStream { return mutableStoryStream }

    init(dependency: LoggedInDependency, userName: String) {
        self.userName = userName
        super.init(dependency: dependency)
    }
}
