//
//  LoginViewModel.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/02/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {}

class LoginViewModel {
    
    var delegate: LoginViewModelDelegate?
    private var emailText: String = ""
    private var passwordText: String = ""
    
    init(delegate: LoginViewModelDelegate?) {
        self.delegate = delegate
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
        
    }
    
    func forgotPasswordButtonPressed() {
        
    }
    
}
