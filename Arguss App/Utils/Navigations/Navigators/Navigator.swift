//
//  Navigator.swift
//  Arguss App
//
//  Created by Diego Atencia on 23/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination)
}
