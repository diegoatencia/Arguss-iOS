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
    let imageViewIconoSobre = UIImageView()
    let mailTextField = UITextField()
    let linea = UIView()
    let continuarButton = UIButton()
    
    //MARK: FUNCIONES
    //Funcion para configuración de la vista
    func mostrarVista(viewController: UIViewController) {
        let vc = viewController as! RecuperarPasswordViewController
        vc.view.backgroundColor = .white
        
        //navigationBar
        vc.navigationController?.navigationBar.barTintColor = colorWithHexString(hexString: celeste)
        vc.navigationController?.navigationBar.tintColor = .white
        vc.title = "Recuperar contraseña"
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //label para info (labelInfo)
        vc.view.addSubview(labelInfo)
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.text = "Para recuperar su contraseña, ingrese su correo electrónico y presione el botón “Continuar”."
        labelInfo.textColor = colorWithHexString(hexString: azulOscuro)
        labelInfo.font = UIFont(name: "Arial-BoldMT", size: 16)
        labelInfo.textAlignment = .center
        labelInfo.numberOfLines = 0
        labelInfo.snp.makeConstraints { (maker) in
            switch alturaIphones {
            case 1792, 2436, 2688:
                maker.top.equalToSuperview().inset(120)
            default:
                maker.top.equalToSuperview().inset(100)
            }
            maker.leading.trailing.equalToSuperview().inset(30)
        }
        
        //imageView para icono sobre
        vc.view.addSubview(imageViewIconoSobre)
        imageViewIconoSobre.translatesAutoresizingMaskIntoConstraints = false
        let imageIconoSobre = UIImage(named: "icono_sobre_mail")
        imageViewIconoSobre.image = imageIconoSobre
        imageViewIconoSobre.contentMode = .scaleAspectFit
        imageViewIconoSobre.tintColor = colorWithHexString(hexString: azulOscuro)
        imageViewIconoSobre.image = imageViewIconoSobre.image?.withRenderingMode(.alwaysTemplate)
        imageViewIconoSobre.snp.makeConstraints { (maker) in
            maker.width.equalTo(23)
            maker.height.equalTo(18)
            maker.leading.equalTo(labelInfo.snp.leading)
            switch alturaIphones {
            case 1792, 2436, 2688:
                maker.top.equalTo(labelInfo.snp.bottom).offset(60)
            default:
                maker.top.equalTo(labelInfo.snp.bottom).offset(40)
            }
        }
        
        //TextField para mail
        vc.view.addSubview(mailTextField)
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.text = ""
        mailTextField.autocapitalizationType = .none
        mailTextField.keyboardType = .emailAddress
        mailTextField.backgroundColor = .white
        mailTextField.adjustsFontSizeToFitWidth = true
        mailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0/255, alpha: 0.3), NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 16)!])
        mailTextField.snp.makeConstraints { (maker) in
            maker.top.equalTo(imageViewIconoSobre.snp.top)
            maker.leading.equalTo(imageViewIconoSobre.snp.trailing).offset(10)
            maker.height.equalTo(imageViewIconoSobre.snp.height)
            maker.trailing.equalToSuperview().inset(30)
        }
        
        //UIView para linea
        vc.view.addSubview(linea)
        linea.translatesAutoresizingMaskIntoConstraints = false
        linea.backgroundColor = colorWithHexString(hexString: azulOscuro)
        linea.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.top.equalTo(mailTextField.snp.bottom).offset(10)
            maker.leading.equalTo(imageViewIconoSobre.snp.leading)
            maker.trailing.equalTo(mailTextField.snp.trailing)
        }
        
        //UIButton para 'Iniciar sesión'
        vc.view.addSubview(continuarButton)
        continuarButton.translatesAutoresizingMaskIntoConstraints = false
        continuarButton.setTitle("Continuar", for: .normal)
        continuarButton.setTitleColor(.white, for: .normal)
        continuarButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        continuarButton.backgroundColor = colorWithHexString(hexString: celeste)
        continuarButton.layer.cornerRadius = 15
        continuarButton.layer.shadowColor = UIColor(red: 6/255, green: 22/255, blue: 52/255, alpha: 0.3).cgColor //Color sombra (azulOscuro en RGB)
        continuarButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0) //Posicion sombra
        continuarButton.layer.shadowOpacity = 1 //Opacidad sombra
        continuarButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(46)
            switch alturaIphones {
            case 1792, 2436, 2688:
                maker.top.equalTo(linea.snp.bottom).offset(60)
            default:
                maker.top.equalTo(linea.snp.bottom).offset(40)
            }
            maker.leading.equalTo(linea.snp.leading)
            maker.trailing.equalTo(linea.snp.trailing)
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
