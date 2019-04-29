//
//  StoryBookViewController.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs
import SnapKit
import UIKit

protocol StoryBookPresentableListener: class {
    func goToNextPage()
    func goToPreviousPage()
}

final class StoryBookViewController: UIViewController, StoryBookViewControllable {
    weak var listener: StoryBookPresentableListener?
    private let textView: UITextView = UITextView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
}

// MARK: Private

private extension StoryBookViewController {
    func setupSubviews() {
        view.backgroundColor = UIColor.lightGray
        view.addSubview(textView)
        textView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.edges.equalToSuperview().inset(16.0)
        }
    }

    func setupLayout() {}
}

// MARK: StoryBookPresentable

extension StoryBookViewController: StoryBookPresentable {
    func setStoryText(_ text: String) {
        textView.text = text
    }
}
