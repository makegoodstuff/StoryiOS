//
//  HomeBuilder.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

public protocol HomeDependency: Dependency {
    var userName: String { get }
    var storyStream: StoryStream { get }
}

final class HomeComponent: Component<HomeDependency>, BasicStoryDependency {
    var userName: String { return dependency.userName }
    var storyStream: StoryStream { return dependency.storyStream }
}

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener, stories: [Story]) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {
    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener, stories: [Story]) -> HomeRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = HomeViewController(stories: stories)
        let interactor = HomeInteractor(presenter: viewController)
        interactor.listener = listener

        let storyBuilder = BasicStoryBuilder(dependency: component)
        let router = HomeRouter(
            interactor: interactor,
            viewController: viewController,
            storyBuilder: storyBuilder
        )
        return router
    }
}
