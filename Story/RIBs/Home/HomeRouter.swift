//
//  HomeRouter.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

protocol HomeInteractable: Interactable, BasicStoryListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func show(storyView: ViewControllable)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    private var storyBuilder: BasicStoryBuildable

    init(interactor: HomeInteractable,
         viewController: HomeViewControllable,
         storyBuilder: BasicStoryBuildable) {
        self.storyBuilder = storyBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        attachStory()
    }
}

private extension HomeRouter {
    func attachStory() {
        let story = storyBuilder.build(withListener: interactor)
        attachChild(story)
        viewController.show(storyView: story.viewControllable)
    }
}
