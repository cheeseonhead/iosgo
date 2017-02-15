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

protocol ___FILEBASENAMEASIDENTIFIER___InteractorInput
{
    func doSomething(request: ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.Request)
}

protocol ___FILEBASENAMEASIDENTIFIER___InteractorOutput
{
    func present___VARIABLE_subject___(response: ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.Response)
}

class ___FILEBASENAMEASIDENTIFIER___Interactor: ___FILEBASENAMEASIDENTIFIER___InteractorInput
{
    var output: ___FILEBASENAMEASIDENTIFIER___InteractorOutput!

    // MARK: - Business logic

    func doSomething(request: ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.Request)
    {
        // NOTE: Create some Worker to do the work

        // NOTE: Pass the result to the Presenter

        let response = ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.Response()
        output.present___VARIABLE_subject___(response: response)
    }
}
