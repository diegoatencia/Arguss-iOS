//
//  LocalizablesManager.swift
//  Arguss App
//
//  Created by Diego Atencia on 18/03/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

class LocalizablesManager {
    var data: Data?
    static var strings: [String: String] = [:]
    
    init(data: Data?) {
        self.data = data
    }
    
    func getStrings() {
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        if let jsonData = json as? [String: Any], let texts = jsonData["data"] as? [String: String] {
            LocalizablesManager.strings = texts
        }
    }
}
