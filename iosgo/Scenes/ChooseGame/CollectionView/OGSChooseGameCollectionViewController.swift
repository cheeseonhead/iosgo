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
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        super.init(collectionViewLayout: flowLayout)

        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView?.register(UINib.init(nibName: "OGSChooseGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constant.cellIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier, for: indexPath)

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
