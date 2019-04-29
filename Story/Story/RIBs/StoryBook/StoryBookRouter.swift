//
//  StoryBookRouter.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs

protocol StoryBookInteractable: Interactable {
    var router: StoryBookRouting? { get set }
    var listener: StoryBookListener? { get set }
}

protocol StoryBookViewControllable: ViewControllable {}

final class StoryBookRouter: ViewableRouter<StoryBookInteractable, StoryBookViewControllable>, StoryBookRouting {
    override init(interactor: StoryBookInteractable, viewController: StoryBookViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
