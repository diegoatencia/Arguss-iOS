//
//  LoginViewController.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/02/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        
        configureTextFields()
        configureSignInButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    private func configureSignInButton() {
        signInButton.isEnabled = false
    }
    
    private func configureTextFields() {
        emailTextField.addTarget(self, action: #selector(editingEmailTextField), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(editingPasswordTextField), for: .editingChanged)
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc private func editingEmailTextField() {
        lineSeparator.backgroundColor = .whiteAndGhostWhite
        mailLoginIcon.image = #imageLiteral(resourceName: "mailLoginSelectedIcon")
        model.storeValue(text: emailTextField.text, inputType: .email)
        enableSignInButton()
    }
    
    @objc private func editingPasswordTextField() {
        lineSeparator2.backgroundColor = .whiteAndGhostWhite
        passwordLoginIcon.image = #imageLiteral(resourceName: "passwordLoginSelectedIcon")
        model.storeValue(text: passwordTextField.text, inputType: .password)
        enableSignInButton()
    }
    
    func enableSignInButton() {
        let shouldBeEnabled: Bool = model.signInButtonShouldBeEnabled()
        if shouldBeEnabled {
            signInButton.isEnabled = true
            //Editar colores si se habilita
        }
    }
    
    private func configureUI() {
        loginMainView.layer.cornerRadius = 50
        loginMainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        signInButton.layer.borderWidth = 2
        signInButton.layer.borderColor = UIColor.oxfordBlueAndCeladonBlue40.cgColor
        signInButton.layer.cornerRadius = 15
        if traitCollection.userInterfaceStyle != .dark {
            signInButton.alpha = 0.4
        } else {
            signInButton.alpha = 1
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

extension LoginViewController: LoginViewModelDelegate {
    
}
