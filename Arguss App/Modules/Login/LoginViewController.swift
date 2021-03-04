//
//  LoginViewController.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/02/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var model: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateStatusBarColor()
        }
    }

}
