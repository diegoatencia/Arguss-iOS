//
//  UIViewController + Extensions.swift
//  Arguss App
//
//  Created by Diego Atencia on 04/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func updateStatusBarColor() {
        var statusBarStyle = UIStatusBarStyle.default
        switch traitCollection.userInterfaceStyle {
        case .light:
            statusBarStyle = .lightContent
        case .dark:
            statusBarStyle = .darkContent
        default:
            statusBarStyle = .default
        }
    }
}
