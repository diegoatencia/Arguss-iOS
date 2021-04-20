//
//  UIViewController + Extensions.swift
//  Arguss App
//
//  Created by Diego Atencia on 04/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    func showToast() {
        let toastView = ToastView()
        toastView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toastView)
        toastView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
        }
        toastView.toastLabel.text = "Hola, soy un toast view"
        toastView.transform = CGAffineTransform(translationX: 0, y: 150)
        UIView.animate(withDuration: 1) {
            toastView.transform = .identity
        }
    }
    
}
