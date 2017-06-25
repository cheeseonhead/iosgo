//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ___VARIABLE_sceneName___RouterInput {}

protocol ___VARIABLE_sceneName___RouterDataProvider: class {}

protocol ___VARIABLE_sceneName___RouterDataReceiver: class {}

class ___VARIABLE_sceneName___Router: ___VARIABLE_sceneName___RouterInput
{
    weak var viewController: UIViewController!
    private weak var dataProvider: ___VARIABLE_sceneName___RouterDataProvider!
    weak var dataReceiver: ___VARIABLE_sceneName___RouterDataReceiver!

    init(viewController: UIViewController, dataProvider: ___VARIABLE_sceneName___RouterDataProvider, dataReceiver: ___VARIABLE_sceneName___RouterDataReceiver)
    {
        self.viewController = viewController
        self.dataProvider = dataProvider
        self.dataReceiver = dataReceiver
    }
}
