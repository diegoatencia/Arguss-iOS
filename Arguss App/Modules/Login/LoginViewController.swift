//
//  LoginViewController.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/02/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginMainView: UIView!
    
    @IBOutlet weak var mailLoginIcon: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lineSeparator: UIView!
    
    @IBOutlet weak var passwordLoginIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lineSeparator2: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    var model: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = LoginViewModel(delegate: self)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        configureTextFields()
        configureSignInButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            lineSeparator.backgroundColor = .whiteAndGhostWhite
            mailLoginIcon.image = #imageLiteral(resourceName: "mailLoginSelectedIcon")
        } else {
            lineSeparator2.backgroundColor = .whiteAndGhostWhite
            passwordLoginIcon.image = #imageLiteral(resourceName: "passwordLoginSelectedIcon")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            lineSeparator.backgroundColor = .oxfordBlueAndDavysGrey
            mailLoginIcon.image = #imageLiteral(resourceName: "mailLoginIcon")
        } else {
            lineSeparator2.backgroundColor = .oxfordBlueAndDavysGrey
            passwordLoginIcon.image = #imageLiteral(resourceName: "passwordLoginIcon")
        }
    }
    
    private func configureSignInButton() {
        signInButton.isEnabled = false
    }
    
    private func configureTextFields() {
        emailTextField.addTarget(self, action: #selector(editingTextFields), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(editingTextFields), for: .editingChanged)
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc private func editingTextFields() {
        if emailTextField.isEditing {
            model.storeValue(text: emailTextField.text, inputType: .email)
            enableSignInButton()
        } else if passwordTextField.isEditing {
            model.storeValue(text: passwordTextField.text, inputType: .password)
            enableSignInButton()
        }
    }
    
    func enableSignInButton() {
        let shouldBeEnabled: Bool = model.signInButtonShouldBeEnabled()
        if shouldBeEnabled {
            signInButton.isEnabled = true
            if traitCollection.userInterfaceStyle != .dark {
                signInButton.alpha = 1
            }
            signInButton.setTitleColor(.oxfordBlueAndCeladonBlue, for: .normal)
            signInButton.layer.borderColor = UIColor.oxfordBlueAndCeladonBlue.cgColor
            signInButton.backgroundColor = .whiteAndBlack
            viewDidLayoutSubviews()
        }
    }
    
    private func configureUI() {
        loginMainView.layer.cornerRadius = 50
        loginMainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = 15
        signInButton.layer.shadowColor = UIColor.oxfordBlue70AndWhite20.cgColor
        signInButton.layer.shadowOpacity = 1.0
        signInButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signInButton.layer.masksToBounds = false
        if emailTextField.text != "" && passwordTextField.text != "" {
            signInButton.alpha = 1
        } else {
            signInButton.layer.borderColor = UIColor.oxfordBlueAndCeladonBlue40.cgColor
            if traitCollection.userInterfaceStyle != .dark {
                signInButton.alpha = 0.4
            } else {
                signInButton.alpha = 1
            }
        }
        
        let emailPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white50AndDavysGrey]
        let emailPlaceholder = NSAttributedString(string: "Email", attributes: emailPlaceholderAttributes)
        emailTextField.attributedPlaceholder = emailPlaceholder
        
        let passwordPlaceholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white50AndDavysGrey]
        let passwordPlaceholder = NSAttributedString(string: "Contraseña", attributes: passwordPlaceholderAttributes)
        passwordTextField.attributedPlaceholder = passwordPlaceholder
        
        forgotPasswordLabel.textColor = .whiteAndSpanishGrey
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Olvidé mi contraseña", attributes: underlineAttribute)
        forgotPasswordLabel.attributedText = underlineAttributedString
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
    }
}

extension LoginViewController: LoginViewModelDelegate {}
