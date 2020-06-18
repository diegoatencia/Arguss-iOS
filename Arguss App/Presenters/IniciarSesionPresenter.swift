import Foundation

protocol IniciarSesionDelegate: NSObjectProtocol {
    
}

class IniciarSesionPresenter {
    weak var delegate: IniciarSesionDelegate?
}
