//
// Created by Cheese Onhead on 3/30/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSChooseGameCollectionViewController: UICollectionViewController
{
    required init()
    {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8

        super.init(collectionViewLayout: flowLayout)

        collectionView?.backgroundColor = UIColor.brown
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
