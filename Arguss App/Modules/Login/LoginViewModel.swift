//
//  LoginViewModel.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/02/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import Firebase
import UIKit

protocol LoginViewModelDelegate: AnyObject {}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    private var emailText: String = ""
    private var passwordText: String = ""
    var navigator: LoginNavigator?
    
    init(delegate: LoginViewModelDelegate?, navigator: LoginNavigator?) {
        self.delegate = delegate
        self.navigator = navigator
    }
    
    func storeValue(text: String?, inputType: LoginInputType) {
        switch inputType {
        case .email:
            emailText = text ?? ""
        default:
            passwordText = text  ?? ""
        }
    }
    
    func signInButtonShouldBeEnabled() -> Bool {
        if emailText != "" && passwordText != "" {
            return true
        } else {
            return false
        }
    }
    
    func signInButtonPressed() {
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (result, error) in
//            if let error = error {
//
//            } else {
//
//            }
        }
    }
    
    func forgotPasswordButtonPressed() {
        navigator?.navigate(to: .forgotPassword)
    }
    
}
