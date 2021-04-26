//
//  ViewControllerFactory.swift
//  Arguss App
//
//  Created by Diego Atencia on 08/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerFactory {
    
    class var login: LoginViewController {
        return controllerFromNib(type: LoginViewController.self)
    }
    
    class func forgotPassword() -> RecoverPasswordViewController {
        let returnable = controllerFromNib(type: RecoverPasswordViewController.self)
        return returnable
    }
}

extension ViewControllerFactory {
    private class func controllerFromNib<T: UIViewController>(type: T.Type) -> T {
        return T.init(nibName: type.className, bundle: nil)
    }
}
