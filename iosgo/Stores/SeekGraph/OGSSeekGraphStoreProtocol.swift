//
// Created by Jeffrey Wu on 2017-02-26.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSSeekGraphStoreDelegate: class
{
    func listChallenges(_ challenges: [OGSSeekGraphStore.Challenge])
}

protocol OGSSeekGraphStoreProtocol
{
    weak var delegate: OGSSeekGraphStoreDelegate? { set get }

    func connect()
}
