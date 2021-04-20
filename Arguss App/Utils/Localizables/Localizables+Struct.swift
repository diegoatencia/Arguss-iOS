//
//  Localizables+Struct.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

///Struct to access Localization enums.
struct L {
    
    ///Enum to access to Login localization strings.
    static var login: LoginLocalization.Type { return LoginLocalization.self }
    
    ///Enum to access to General localization strings.
    static var gen: GeneralLocalization.Type { return GeneralLocalization.self }
}
