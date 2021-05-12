//
//  RecoverPasswordViewController.swift
//  Arguss App
//
//  Created by Diego Atencia on 20/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: UIViewController {
    
    @IBOutlet weak var recoverMainView: UIView!
    
    @IBOutlet weak var mailIconImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lineSeparator: UIView!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelLabel: UILabel!
    
    var model: RecoverPasswordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        recoverMainView.layer.cornerRadius = 50
        recoverMainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        continueButton.layer.borderWidth = 2
        continueButton.layer.cornerRadius = 15
        continueButton.layer.shadowColor = UIColor.oxfordBlue70AndWhite20.cgColor
        continueButton.layer.shadowOpacity = 1.0
        continueButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        continueButton.layer.masksToBounds = false
        if emailTextField.text != "" {
            continueButton.alpha = 1
        } else {
            continueButton.layer.borderColor = UIColor.oxfordBlueAndCeladonBlue40.cgColor
            if traitCollection.userInterfaceStyle != .dark {
                continueButton.alpha = 0.4
            } else {
                continueButton.alpha = 1
            }
        }
        
        let emailPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white50AndDavysGrey]
        let emailPlaceholder = NSAttributedString(string: "Email", attributes: emailPlaceholderAttributes)
        emailTextField.attributedPlaceholder = emailPlaceholder
        
        cancelLabel.textColor = .whiteAndSpanishGrey
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Cancelar", attributes: underlineAttribute)
        cancelLabel.attributedText = underlineAttributedString
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
    }
}

extension RecoverPasswordViewController: RecoverPasswordViewModelDelegate {
    
}
