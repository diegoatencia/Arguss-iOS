//
//  RecoverPasswordViewModel.swift
//  Arguss App
//
//  Created by Diego Atencia on 20/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

protocol RecoverPasswordViewModelDelegate: class {
    
}

class RecoverPasswordViewModel {
    weak var delegate: RecoverPasswordViewModelDelegate?
    var navigator: LoginNavigator?
    
    init(delegate: RecoverPasswordViewModelDelegate?, navigator: LoginNavigator?) {
        self.delegate = delegate
        self.navigator = navigator
    }
}
