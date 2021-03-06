//
// Created by Cheese Onhead on 3/30/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import UIKit

enum OGSChooseGameAction
{
    case accept
    case remove
}

protocol OGSChooseGameCollectionViewControllerDelegate: class
{
    func selected(challengeAt indexPath: IndexPath, action: OGSChooseGameAction)
}

class OGSChooseGameCollectionViewController: UICollectionViewController
{
    fileprivate struct Style
    {
        static var backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static var estimatedCellSize = CGSize(width: 100, height: 100)

        struct Layout
        {
            static var spacing: CGFloat = 8
        }
    }

    fileprivate struct Constant
    {
        static var cellIdentifier = "OGSChooseGameCollectionViewCell"
    }

    typealias Challenge = OGSChooseGame.ListGames.ViewModel.Challenge

    var challengeList: [Challenge] = []
    {
        didSet
        {
            self.collectionView!.reloadData()
            self.collectionView!.collectionViewLayout.invalidateLayout()
        }
    }

    weak var delegate: OGSChooseGameCollectionViewControllerDelegate?

    required init()
    {
        let layout = type(of: self).createLayout()
        super.init(collectionViewLayout: layout)

        collectionView?.backgroundColor = Style.backgroundColor
        collectionView?.register(UINib.init(nibName: "OGSChooseGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constant.cellIdentifier)
    }

    required init?(coder _: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Data Source
extension OGSChooseGameCollectionViewController: UICollectionViewDelegateFlowLayout
{
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int
    {
        return challengeList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let challenge = challengeList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier, for: indexPath) as! OGSChooseGameCollectionViewCell

        cell.delegate = self
        cell.userInfoLabel.text = challenge.userInfo
        cell.timeLabel.text = challenge.timeString
        cell.sizeLabel.text = challenge.sizeString
        cell.buttonType = cellButtonType(from: challenge.buttonType)

        return cell
    }
}

// MARK: Delegate
extension OGSChooseGameCollectionViewController: OGSChooseGameCollectionViewCellDelegate
{
    func buttonTapped(cell: OGSChooseGameCollectionViewCell)
    {
        guard let indexPath = collectionView?.indexPath(for: cell) else
        {
            return
        }

        switch cell.buttonType {
        case .play:
            delegate?.selected(challengeAt: indexPath, action: .accept)
        case .remove:
            delegate?.selected(challengeAt: indexPath, action: .remove)
        default:
            break
        }
    }
}

// MARK: Stateless Helpers
extension OGSChooseGameCollectionViewController
{
    func cellButtonType(from challengeButtonType: Challenge.ButtonType) -> OGSChooseGameCollectionViewCell.ButtonType
    {
        switch challengeButtonType {
        case .play:
            return .play
        case .remove:
            return .remove
        case .cantPlay:
            return .cantPlay
        }
    }
}

// MARK: TableViewLayout
extension OGSChooseGameCollectionViewController
{
    class func createLayout() -> UICollectionViewFlowLayout
    {
        let flowLayout = TableViewLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = Style.Layout.spacing
        flowLayout.estimatedItemSize = Style.estimatedCellSize
        flowLayout.sectionInset = UIEdgeInsets(top: Style.Layout.spacing, left: 0, bottom: Style.Layout.spacing, right: 0)

        return flowLayout
    }

    fileprivate class TableViewLayout: UICollectionViewFlowLayout
    {
        private var contentWidth: CGFloat
        {
            return collectionView!.frame.size.width
        }

        override func prepare()
        {
            super.prepare()
            estimatedItemSize = CGSize(width: contentWidth, height: Style.estimatedCellSize.height)
        }
    }
}
