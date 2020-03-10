import UIKit
import SnapKit
import Firebase

class HomeAdminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        vistaGradiente() /*Funcion para poner gradiente al fondo*/
    }
    
    //MARK: FUNCIONES UTILIDADES
    
    
    //MARK: FUNCIONES DISEÑO VISTA
    /* Funcion para vista gradiente */
    func vistaGradiente(){
        let gradientLayer = CAGradientLayer()
        let customAzul = UIColor(red: 137/255, green: 177/255, blue: 223/255, alpha: 1)
        gradientLayer.colors = [UIColor.white.cgColor, customAzul.cgColor]
        gradientLayer.frame = view.frame
        
        view.layer.addSublayer(gradientLayer)
    }

    //MARK: FUNCIONES LÓGICA SISTEMA
    
}
