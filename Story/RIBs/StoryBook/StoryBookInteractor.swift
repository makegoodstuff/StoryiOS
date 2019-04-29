//
//  StoryBookInteractor.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs
import RxSwift

public protocol StoryBookRouting: ViewableRouting {}

protocol StoryBookPresentable: Presentable {
    var listener: StoryBookPresentableListener? { get set }
    func setStoryText(text: String)
}

public protocol StoryBookListener: class {
    func storyBookDidEnd()
}

final class StoryBookInteractor: PresentableInteractor<StoryBookPresentable>, StoryBookInteractable {
    weak var router: StoryBookRouting?
    weak var listener: StoryBookListener?

    private let mutableStoryStream: MutableStoryStream
    private var story = Story?

    init(presenter: StoryBookPresentable,
         mutableStoryStream: MutableStoryStream) {
        self.mutableStoryStream = mutableStoryStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        initBoard()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

// MARK: StoryBookPresentableListener

extension StoryBookInteractor: StoryBookPresentableListener {
    func goToNextPage() {
        if story.page == story.pages {
            listener?.storyBookDidEnd()
        } else {
            // TODO: Go to next page
        }
    }

    func goToPreviousPage() {
        // TODO: Go to previous page
    }
}
