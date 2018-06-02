//
//  PlayerInfoView.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-04-19.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

@IBDesignable
class PlayerInfoView: UIView {
    struct ViewModel {
        let profile: UIImage
        let username: String

        static let `default` = ViewModel(profile: #imageLiteral(resourceName: "Spaceship"), username: "Loading...")
    }

    let infoRelay = BehaviorRelay(value: ViewModel.default)
    let timeRelay = BehaviorRelay(value: "Loading...")

    private let disposeBag = DisposeBag()

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var capturesLabel: UILabel!

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
        infoRelay.asDriver()
            .drive(onNext: { [unowned self] model in
                self.usernameLabel.text = model.username
                self.profileImage.image = model.profile
            })
            .disposed(by: disposeBag)

        timeRelay.asDriver()
            .drive(onNext: { [unowned self] timeStr in
                self.timeLabel.text = timeStr
            })
            .disposed(by: disposeBag)
    }

    //    func setTime(_ time: String) {
    //        timeLabel.text = time
    //    }
    //
    //    func setUser(_ model: PlayerInfoViewModels.User, color _: PlayerType) {
    //        profileImage.image = model.profile
    //        usernameLabel.text = model.username
    //    }
}
