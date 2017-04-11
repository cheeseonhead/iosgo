//
// Created by Cheese Onhead on 3/30/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSChooseGameCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    fileprivate struct Style
    {
        static var cellHeight: CGFloat = 100
    }

    fileprivate struct Constant
    {
        static var cellIdentifier = "OGSChooseGameCollectionViewCell"
    }

    required init()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8

        super.init(collectionViewLayout: flowLayout)

        collectionView?.backgroundColor = UIColor.brown
        collectionView?.register(UINib.init(nibName: "OGSChooseGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constant.cellIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier, for: indexPath)

        cell.backgroundColor = UIColor.black

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.size.width, height: Style.cellHeight)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
