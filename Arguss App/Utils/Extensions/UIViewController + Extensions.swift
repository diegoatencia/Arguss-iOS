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
    func showToastView(toastStyle: ToastViewStyle) {
        let boldText = toastStyle.boldText
        let normalText = toastStyle.normalText
        
        let toastView = ToastView()
        toastView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toastView)
        toastView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        let attributedText = configureToastViewText(boldText: boldText, normalText: normalText)
        toastView.toastLabel.attributedText = attributedText
        
        toastView.transform = CGAffineTransform(translationX: 0, y: 150)
        UIView.animate(withDuration: 1) {
            toastView.transform = .identity
        }
    }
    
    private func configureToastViewText(boldText: String = "", normalText: String = "") -> NSMutableAttributedString {
        let boldFont = UIFont.montserrat(style: .bold, size: 12)
        let boldAttributes = [NSAttributedString.Key.font: boldFont]
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        
        let normalFont = UIFont.montserrat(style: .medium, size: 12)
        let normalAttributes = [NSAttributedString.Key.font: normalFont]
        let normalString = NSMutableAttributedString(string: normalText, attributes: normalAttributes)
        attributedString.append(normalString)
        
        return attributedString
    }
    
    func hideToastIndicator() {
        guard let toastView = view.subviews.first(where: {
            $0 is ToastView
        }) else {
            return
        }
        UIView.animate(withDuration: 1, animations: {
            toastView.transform = CGAffineTransform(translationX: 0, y: 150)
        }, completion: { _ in
            toastView.removeFromSuperview()
        })
    }
    
    class var className: String {
        return String(describing: Self.self)
    }
}
