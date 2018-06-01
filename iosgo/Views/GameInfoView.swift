//
//  GameInfoViewController.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-19.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SnapKit
import UIKit

@IBDesignable
class GameInfoView: UIView {
    struct ViewModel {
        let one: PlayerInfoView.ViewModel
        let two: PlayerInfoView.ViewModel

        static let `default` = ViewModel(one: PlayerInfoView.ViewModel.default, two: PlayerInfoView.ViewModel.default)
    }

    let viewModel = BehaviorRelay(value: ViewModel.default)

    @IBOutlet var topInfoView: PlayerInfoView!
    @IBOutlet var bottomInfoView: PlayerInfoView!

    private let disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromIBDesignable()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromIBDesignable()
        setupBindings()
    }

    func setupBindings() {
        viewModel.asDriver()
            .flatMapLatest { model in
                BehaviorRelay(value: model.one).asDriver()
            }.drive(topInfoView.viewModel)
            .disposed(by: disposeBag)

        viewModel.asDriver()
            .flatMapLatest { model in
                BehaviorRelay(value: model.two).asDriver()
            }.drive(bottomInfoView.viewModel)
            .disposed(by: disposeBag)
    }

//    func setClocks(blackTime: String, whiteTime: String) {
//        topInfoView.setTime(blackTime)
//        bottomInfoView.setTime(whiteTime)
//    }
//
//    func setUsers(black: PlayerInfoViewModels.User, white: PlayerInfoViewModels.User) {
//        topInfoView.setUser(black, color: .black)
//        bottomInfoView.setUser(white, color: .white)
//    }
}
