//
//  StoryBuilder.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

protocol StoryBuildable: Buildable {
    func build(withListener listener: StoryListener) -> StoryRouting
}

final class StoryBuilder: Builder<StoryDependency>, StoryBuildable {
    override init(dependency: StoryDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StoryListener) -> StoryRouting {
        let component = StoryComponent(dependency: dependency)
        let viewController = StoryViewController()
        let interactor = StoryInteractor(presenter: viewController)
        interactor.listener = listener
        return StoryRouter(interactor: interactor, viewController: viewController)
    }
}
