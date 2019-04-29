//
//  StoryStream.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import Foundation
import RxSwift

public struct Story {
    public var page: Int
    public let pages: Int
    public static func equals(lhs: Story, rhs: Story) -> Bool {
        return lhs.page == rhs.page && lhs.pages == rhs.pages
    }
}

public protocol StoryStream: class {
    var story: Observable<Story> { get }
}

public protocol MutableStoryStream: StoryStream {
    func nextPage()
}

public class StoryStreamImpl: MutableStoryStream {
    private let variable = Variable<Story>(Story(page: 0, pages: 4))

    public init() {}

    public var story: Observable<Story> {
        return variable
            .asObservable()
            .distinctUntilChanged { (lhs: Story, rhs: Story) -> Bool in
                Story.equals(lhs: lhs, rhs: rhs)
        }
    }

    public func nextPage() {
        var story: Story = variable.value
        story.page += 1
        variable.value = story
    }
}
