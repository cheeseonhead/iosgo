//
//  OGSChooseGameViewController.swift
//  iosgo
//
//  Created by Jeffrey Wu on 2017-02-26.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SnapKit

protocol OGSChooseGameViewControllerInput
{
    func displayListGames(viewModel: OGSChooseGame.ListGames.ViewModel)
    func displayTouchGame(viewModel: OGSChooseGame.TouchGame.ViewModel)
}

protocol OGSChooseGameViewControllerOutput
{
    func listGames(request: OGSChooseGame.ListGames.Request)
    func touchGame(request: OGSChooseGame.TouchGame.Request)
}

class OGSChooseGameViewController: UIViewController
{
    var output: OGSChooseGameViewControllerOutput!
    var router: OGSChooseGameRouter!
    var listViewController: OGSChooseGameCollectionViewController!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        OGSChooseGameConfigurator.sharedInstance.configure(viewController: self)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        listGamesOnLoad()
    }
}

// MARK: - Event Handling
fileprivate extension OGSChooseGameViewController
{
    func listGamesOnLoad()
    {
        let request = OGSChooseGame.ListGames.Request()

        output.listGames(request: request)
    }
}

extension OGSChooseGameViewController: OGSChooseGameCollectionViewControllerDelegate
{
    func selected(challengeAt indexPath: IndexPath, action: OGSChooseGameAction)
    {
        var actionType: OGSChooseGame.TouchGame.ActionType!

        switch action {
        case .accept:
            actionType = .accept
        case .remove:
            actionType = .remove
        }

        let request = OGSChooseGame.TouchGame.Request(indexPath: indexPath, action: actionType)
        output.touchGame(request: request)
    }
}

// MARK: - Display Logic
extension OGSChooseGameViewController: OGSChooseGameViewControllerInput
{
    func displayListGames(viewModel: OGSChooseGame.ListGames.ViewModel)
    {
        listViewController.challengeList = viewModel.challengeList
    }

    func displayTouchGame(viewModel: OGSChooseGame.TouchGame.ViewModel)
    {
        switch viewModel.nextAction {
        case .navigate:
            router.navigateToChallenge()
        case .alert(let message):
            print(message)
        }
    }
}

// MARK: - View Setup
extension OGSChooseGameViewController
{
    func setupViews()
    {
        //        automaticallyAdjustsScrollViewInsets = false
        setupCollectionView()
    }

    func setupCollectionView()
    {
        listViewController = OGSChooseGameCollectionViewController()
        listViewController.delegate = self
        addChildViewController(listViewController)
        view.addSubview(listViewController.collectionView!)

        listViewController.collectionView?.snp.makeConstraints
        { make in
            make.edges.equalToSuperview()
        }
    }
}