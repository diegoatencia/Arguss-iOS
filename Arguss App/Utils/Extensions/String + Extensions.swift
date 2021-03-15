//
//  String + Extensions.swift
//  Arguss App
//
//  Created by Diego Atencia on 12/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

extension String {
    func matches(regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidEmail: Bool {
        return matches(regex: RegularExpressions.email)
    }
    
    var isValidPassword: Bool {
        return matches(regex: RegularExpressions.password)
    }
}
