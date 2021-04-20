//
//  Localizable.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

extension String {
    var localized: String { return NSLocalizedString(self, comment: "") }

    func localized(arguments args: CVarArg...) -> String {
        return String(format: self.localized, arguments: args)
    }
}

enum GeneralLocalization: Int {
    case empty = 0
    
    var s: String { return key.localized }
    var key: String { return "General_\(self)" }
}

enum LoginLocalization: Int {
    case emailPlaceholder = 0, passwordPlaceholder, forgotPassword
    
    var s: String { return key.localized }
    var key: String { return "Login_\(self)" }
}
