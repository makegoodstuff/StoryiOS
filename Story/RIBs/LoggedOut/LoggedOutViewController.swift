//
//  LoggedOutViewController.swift
//  Story
//
//  Created by Justin Kaufman on 4/29/19.
//  Copyright © 2019 MakeGoodStuff. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit
import UIKit
import StoryFramework

// MARK: PresentableListener

protocol LoggedOutPresentableListener: class {
    func login(userName: String?)
}

// MARK: ViewController

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    weak var listener: LoggedOutPresentableListener?
    private let disposeBag = DisposeBag()
    private let languageFacts = LanguageFactRepository().fetchLanguageFacts()

    init() {
        super.init(nibName: nil, bundle: nil)
        setupSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
}

// MARK: Private

private extension LoggedOutViewController {
    func setupSubviews() {
        view.backgroundColor = UIColor.white
        let userField = buildUserField()
        buildLoginButton(userField: userField)


    }

    func setupLayout() {}
}

// MARK: Control Builders

private extension LoggedOutViewController {
    func buildUserField() -> UITextField {
        let userField = UITextField()
        userField.borderStyle = UITextField.BorderStyle.line
        view.addSubview(userField)
        userField.placeholder = "User name"
        userField.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100.0)
            maker.leading.trailing.equalTo(self.view).inset(40.0)
            maker.height.equalTo(40.0)
        }
        return userField
    }

    func buildLoginButton(userField: UITextField) {
        let loginButton: UIButton = UIButton()
        view.addSubview(loginButton)

        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(userField.snp.bottom).offset(20.0)
            maker.left.right.height.equalTo(userField)
        }

        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.login(userName: userField.text)
            })
            .disposed(by: disposeBag)
    }
}
