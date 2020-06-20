import Foundation
import Firebase

protocol IniciarSesionDelegate: NSObjectProtocol {
    func iniciarSesion(tipoInicio: String) //Recibiria 'inicio_usuario', 'inicio_admin', 'no_usuario', 'contraseña_incorrecta', 'otro_error'
}

class IniciarSesionPresenter/*: InicioSesionDelegate*/ {
    
    //MARK: ATRIBUTOS
    let iniciarSesionServicio = IniciarSesionServicio()
    
    weak var delegate: IniciarSesionDelegate?
    var db: Firestore?
    
    func inicioSesion(mail: String, contraseña: String) {
        iniciarSesionServicio.db = self.db
        print("llamada al metodo del servicio desde presenter")
        let resultado: String = iniciarSesionServicio.iniciarSesion(mail: mail, contraseña: contraseña)
        print("resultado en presenter: \(resultado)")
        delegate?.iniciarSesion(tipoInicio: resultado)
    }
    
    /*func inicioSesion_Servicio(mail: String, contraseña: String) {
        iniciarSesionServicio.db = self.db
        let resultado: String = iniciarSesionServicio.iniciarSesion(mail: mail, contraseña: contraseña)
        delegate?.iniciarSesion(tipoInicio: resultado)
    }*/
    
}

/* RESUMEN
 -Presenter creado (se creo la clase y el protocolo). La clase es un delegado, también, del protocolo del servicio, ya que
  recibe informacion del servicio
 
 TERMINAR:
 - Agregar prints para hacer evaluación posterior
 -Verificar funcionamiento
 */
