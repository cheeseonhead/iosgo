//
// Created by Cheese Onhead on 3/30/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

class OGSChooseGameCollectionViewController: UICollectionViewController
{
    fileprivate struct Style
    {
        static var backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static var cellHeight: CGFloat = 100

        struct Layout
        {
            static var spacing: CGFloat = 8
        }
    }

    fileprivate struct Constant
    {
        static var cellIdentifier = "OGSChooseGameCollectionViewCell"
    }

    required init()
    {
        let layout = type(of: self).createLayout()
        super.init(collectionViewLayout: layout)

        collectionView?.backgroundColor = Style.backgroundColor
        collectionView?.register(UINib.init(nibName: "OGSChooseGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constant.cellIdentifier)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Data Source
extension OGSChooseGameCollectionViewController: UICollectionViewDelegateFlowLayout
{
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
}

// MARK: Properties
extension OGSChooseGameCollectionViewController
{
    class func createLayout() -> UICollectionViewFlowLayout
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = Style.Layout.spacing
        flowLayout.sectionInset = UIEdgeInsets(top: Style.Layout.spacing, left: 0, bottom: Style.Layout.spacing, right: 0)

        return flowLayout
    }
}
