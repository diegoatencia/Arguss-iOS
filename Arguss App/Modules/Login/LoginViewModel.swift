//
//  LoginViewModel.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/02/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    
}

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
        case .password:
            passwordText = text  ?? ""
        default:
            break
        }
    }
    
    func signInButtonShouldBeEnabled() -> Bool {
        return isValid(text: emailText, inputType: .email) && isValid(text: passwordText, inputType: .password)
    }
    
    func isValid(text: String?, inputType: LoginInputType) -> Bool {
        switch inputType {
        case .email:
            return text?.isValidEmail ?? false
        case .password:
            return text?.isValidPassword ?? false
        default:
            return false
        }
    }
    
    func signInButtonPressed() {
        
    }
    
    func forgotPasswordButtonPressed() {
        
    }
    
}
