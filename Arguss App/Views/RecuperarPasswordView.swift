import UIKit

@available(iOS 13.0, *)
class RecuperarPasswordView: UIView {

    //MARK: ATRIBUTOS
    //Colores
    let grisClaro = "#EFEFF4"
    let azulOscuro = "#061634"
    let celeste = "#167FB0"
    
    //Altura dispositivos
    let alturaIphones = UIScreen.main.nativeBounds.height
    
    //Objetos de la vista
    let labelInfo = UILabel()
    
    //MARK: FUNCIONES
    //Funcion para configuración de la vista
    func mostrarVista(viewController: UIViewController) {
        let vc = viewController as! RecuperarPasswordViewController
        vc.view.backgroundColor = .white
        
        //Configuracion vista navBar
        vc.navigationController?.navigationBar.barTintColor = colorWithHexString(hexString: celeste)
        vc.navigationController?.navigationBar.tintColor = .white
        vc.title = "Recuperar contraseña"
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //Configuracion labelInfo
        vc.view.addSubview(labelInfo)
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.text = "Para recuperar su contraseña, ingrese su correo electrónico y presione el botón “Continuar”."
        labelInfo.textColor = colorWithHexString(hexString: azulOscuro)
        labelInfo.font = UIFont(name: "Arial-BoldMT", size: 16)
        labelInfo.textAlignment = .center
        labelInfo.numberOfLines = 0
        labelInfo.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(115)
            maker.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    //Funcion para usar colores en terminología hexagesimal
    func colorWithHexString(hexString:String) -> UIColor {
        var rgb: UInt32 = 0
        let s: Scanner = Scanner(string: hexString as String)
        s.scanLocation = 1
        s.scanHexInt32(&rgb)
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
