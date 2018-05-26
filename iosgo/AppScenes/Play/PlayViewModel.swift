//
//  PlayViewModel.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2018-05-26.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import RxSwift

struct PlayViewModel {
    let model: PlayModel

    private let disposeBag = DisposeBag()

    init(model: PlayModel) {
        self.model = model

        self.model.test.asObservable()
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }
}
