//
//  StoryBookBuilder.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

protocol StoryBookBuildable: Buildable {
    func build(withListener listener: StoryBookListener) -> StoryBookRouting
}

final class StoryBookBuilder: Builder<StoryBookDependency>, StoryBookBuildable {
    override init(dependency: StoryBookDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StoryBookListener) -> StoryBookRouting {
        let component = StoryBookComponent(dependency: dependency)
        let viewController = StoryBookViewController()
        let interactor = StoryBookInteractor(presenter: viewController, mutableStoryStream: component.mutableStoryStream)
        interactor.listener = listener
        return StoryBookRouter(interactor: interactor, viewController: viewController)
    }
}
