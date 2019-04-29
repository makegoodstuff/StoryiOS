//
//  RootInteractor.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToLoggedIn(userName: String) -> LoggedInActionableItem
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    weak var router: RootRouting?
    weak var listener: RootListener?

    private let loggedInActionableItemSubject = ReplaySubject<LoggedInActionableItem>.create(bufferSize: 1)

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

// MARK: RootActionableItem

extension RootInteractor: RootActionableItem {
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())> {
        return loggedInActionableItemSubject
            .map { (loggedInItem: LoggedInActionableItem) -> (LoggedInActionableItem, ()) in
                (loggedInItem, ())
        }
    }
}

// MARK: UrlHandler

extension RootInteractor: UrlHandler {
    func handle(_ url: URL) {
        let launchStoryWorkflow = LaunchStoryWorkflow(url: url)
        launchStoryWorkflow
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
}

// MARK: LoggedOutListener

extension RootInteractor {
    func didLogin(userName: String) {
        let loggedInActionableItem = router?.routeToLoggedIn(userName: userName)
        if let loggedInActionableItem = loggedInActionableItem {
            loggedInActionableItemSubject.onNext(loggedInActionableItem)
        }
    }
}
