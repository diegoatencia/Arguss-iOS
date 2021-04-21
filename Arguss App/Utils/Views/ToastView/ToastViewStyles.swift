//
//  ToastViewStyles.swift
//  Arguss App
//
//  Created by Diego Atencia on 21/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit

protocol ToastViewStyle {
    var boldText: String { get }
    var normalText: String { get }
}

struct UserNotFoundToastStyle: ToastViewStyle {
    var boldText: String { return "No se encontró usuario con el mail ingresado. " }
    var normalText: String { return "Verifique que sea correcto e intente nuevamente." }
}

struct NotValidEmailToastStyle: ToastViewStyle {
    var boldText: String { return "El mail ingresado no es válido. " }
    var normalText: String { return "Intente nuevamente." }
}

struct NotCorrectPasswordToastStyle: ToastViewStyle {
    var boldText: String { return "La contraseña ingresada es incorrecta. " }
    var normalText: String { return "Verifique e intente nuevamente." }
}

struct NotInternetConnectionToastStyle: ToastViewStyle {
    var boldText: String { return "No se ha encontrado conexión a internet. " }
    var normalText: String { return "Verifique su conexión e intente nuevamente." }
}

struct GenericErrorToastStyle: ToastViewStyle {
    var boldText: String { return "Ha ocurrido un error al cargar datos. " }
    var normalText: String { return "Reintente o pruebe nuevamente más tarde." }
}
