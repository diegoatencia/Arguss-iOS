//
//  LoginNavigator.swift
//  Arguss App
//
//  Created by Diego Atencia on 23/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit

class LoginNavigator: NSObject, Navigator {
    enum Destination {
        case forgotPassword
    }
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController
    }
    
    override private init() {}
    
    func navigate(to destination: Destination) {
        switch destination {
        case .forgotPassword:
            forgotPassword()
        }
    }
    
    private func forgotPassword() {
        let controller = ViewControllerFactory.forgotPassword()
        controller.model = RecoverPasswordViewModel(delegate: controller, navigator: self)
        navigationController?.pushViewController(controller, animated: true)
    }
}
