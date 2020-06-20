import UIKit

class Alertas {
    
    //Funcion para presentar alerta
    func presentarAlerta(alerta: UIAlertController, acciones: [UIAlertAction], vc: UIViewController) {
        for accion in acciones {
            alerta.addAction(accion)
            vc.present(alerta, animated: true, completion: nil)
        }
    }
    
}
