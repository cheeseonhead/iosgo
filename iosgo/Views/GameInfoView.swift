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
    
    struct TimeViewModel {
        let one: String
        let two: String
        
        private static let placeholder = NSLocalizedString("Loading...", comment: "GameInfoView.loading")
        static let `default` = TimeViewModel(one: TimeViewModel.placeholder, two: TimeViewModel.placeholder)
    }

//    let viewModel = BehaviorRelay(value: ViewModel.default)
    let infoSequence = BehaviorRelay(value: ViewModel.default)
    let timeSequence = BehaviorRelay(value: TimeViewModel.default)

    @IBOutlet var topInfoView: PlayerInfoView!
    @IBOutlet var bottomInfoView: PlayerInfoView!

    private let disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromIBDesignable()
        setupBindings()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromIBDesignable()
        setupBindings()
    }

    func setupBindings() {
        drive(relay: topInfoView.infoRelay, with: infoSequence, keyPath: \ViewModel.one)
        drive(relay: bottomInfoView.infoRelay, with: infoSequence, keyPath: \ViewModel.two)
        
        drive(relay: topInfoView.timeRelay, with: timeSequence, keyPath: \TimeViewModel.one)
        drive(relay: bottomInfoView.timeRelay, with: timeSequence, keyPath: \TimeViewModel.two)
    }
    
    func drive<T, U>(relay: BehaviorRelay<T>, with observable: BehaviorRelay<U>, keyPath: KeyPath<U, T>) {
        observable.asDriver()
            .debug("Tets", trimOutput: true)
            .flatMapLatest { model -> Driver<T> in
                BehaviorRelay(value: model[keyPath: keyPath]).asDriver()
            }.drive(relay)
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
