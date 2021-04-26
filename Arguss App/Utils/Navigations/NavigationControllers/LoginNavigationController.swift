//
//  LoginNavigationController.swift
//  Arguss App
//
//  Created by Diego Atencia on 25/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit

class LoginNavigationController: UINavigationController {
    enum Destination {
        case login
        
        var viewController: UIViewController {
            switch self {
            case .login: return ViewControllerFactory.login
            }
        }
    }
    
    lazy var navigator = LoginNavigator(navigationController: self)
    
    init(withInitialViewController initialDestination: Destination) {
        super.init(rootViewController: initialDestination.viewController)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
    }
}
