import UIKit
import SnapKit

class IniciarSesionView: UIView {
    
    //Colores
    let grisClaro = "#EFEFF4"
    let azulOscuro = "#061634"
    let celeste = "#167FB0"
    
    //Altura dispositivos
    let alturaIphones = UIScreen.main.nativeBounds.height
    
    //Objetos de la vista
    let imageViewLogo = UIImageView()
    let viewBlanca = UIView()
    let bienvenidoLabel = UILabel()
    let imageViewIconoSobre = UIImageView()
    let mailTextField = UITextField()
    let linea1 = UIView()
    let imageViewIconoCandado = UIImageView()
    let contraseñaTextField = UITextField()
    let linea2 = UIView()
    let iniciarSesionButton = UIButton()
    let olvidarContraseñaButton = UIButton()
    
    //Funcion para configuración de la vista
    func mostrarVista(viewController: UIViewController) {
        let vc = viewController
        vc.view.backgroundColor = colorWithHexString(hexString: grisClaro)
        
        //imageView para logo
        vc.view.addSubview(imageViewLogo)
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        let imageLogo = UIImage(named: "logo_svg")
        imageViewLogo.image = imageLogo
        imageViewLogo.contentMode = .scaleAspectFit
        imageViewLogo.snp.makeConstraints { (maker) in
            maker.height.equalTo(150) //Altura
            maker.width.equalTo(153) //Ancho
            maker.centerX.equalToSuperview() //Posicionamiento horizontal
            switch alturaIphones { //Switch para posicionamiento vertical
            case 1792, 2688:
                maker.top.equalToSuperview().inset(vc.view.frame.height * 0.09)
            case 2436:
                maker.top.equalToSuperview().inset(vc.view.frame.height * 0.07)
            default:
                maker.top.equalToSuperview().inset(vc.view.frame.height * 0.06)
            }
        }
        
        //view blanca para botones
        vc.view.addSubview(viewBlanca)
        viewBlanca.translatesAutoresizingMaskIntoConstraints = false
        viewBlanca.backgroundColor = UIColor.white
        viewBlanca.layer.cornerRadius = 50
        viewBlanca.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] //Esquinas a redondear
        viewBlanca.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.689)
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        //Label "Bienvenido/a"
        viewBlanca.addSubview(bienvenidoLabel)
        bienvenidoLabel.translatesAutoresizingMaskIntoConstraints = false
        bienvenidoLabel.text = "Bienvenido/a"
        bienvenidoLabel.textColor = colorWithHexString(hexString: azulOscuro)
        bienvenidoLabel.font = UIFont(name: "Arial-BoldMT", size: 26)
        bienvenidoLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(30)
            maker.top.equalTo(45)
        }
        
        //imageView para icono sobre
        viewBlanca.addSubview(imageViewIconoSobre)
        imageViewIconoSobre.translatesAutoresizingMaskIntoConstraints = false
        let imageIconoSobre = UIImage(named: "icono_sobre_mail")
        imageViewIconoSobre.image = imageIconoSobre
        imageViewIconoSobre.contentMode = .scaleAspectFit
        imageViewIconoSobre.tintColor = colorWithHexString(hexString: azulOscuro)
        imageViewIconoSobre.image = imageViewIconoSobre.image?.withRenderingMode(.alwaysTemplate)
        imageViewIconoSobre.snp.makeConstraints { (maker) in
            maker.width.equalTo(23)
            maker.height.equalTo(18)
            maker.leading.equalTo(bienvenidoLabel.snp.leading)
            maker.top.equalTo(bienvenidoLabel.snp.bottom).offset(65)
        }
        
        //TextField para mail
        viewBlanca.addSubview(mailTextField)
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
        
        //UIView para linea1
        viewBlanca.addSubview(linea1)
        linea1.translatesAutoresizingMaskIntoConstraints = false
        linea1.backgroundColor = colorWithHexString(hexString: azulOscuro)
        linea1.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.top.equalTo(mailTextField.snp.bottom).offset(10)
            maker.leading.equalTo(imageViewIconoSobre.snp.leading)
            maker.trailing.equalTo(mailTextField.snp.trailing)
        }
        
        //imageView para icono candado de contraseña
        viewBlanca.addSubview(imageViewIconoCandado)
        imageViewIconoCandado.translatesAutoresizingMaskIntoConstraints = false
        let imageIconoCandado = UIImage(named: "icono_candado_contraseña")
        imageViewIconoCandado.image = imageIconoCandado
        imageViewIconoCandado.contentMode = .scaleAspectFit
        imageViewIconoCandado.tintColor = colorWithHexString(hexString: azulOscuro)
        imageViewIconoCandado.image = imageViewIconoCandado.image?.withRenderingMode(.alwaysTemplate)
        imageViewIconoCandado.snp.makeConstraints { (maker) in
            maker.width.equalTo(23)
            maker.height.equalTo(30)
            maker.leading.equalTo(bienvenidoLabel.snp.leading)
            maker.top.equalTo(linea1.snp.bottom).offset(40)
        }
        
        //TextField para contraseña
        viewBlanca.addSubview(contraseñaTextField)
        contraseñaTextField.translatesAutoresizingMaskIntoConstraints = false
        contraseñaTextField.text = ""
        contraseñaTextField.autocapitalizationType = .none
        contraseñaTextField.isSecureTextEntry = true
        contraseñaTextField.backgroundColor = .white
        contraseñaTextField.adjustsFontSizeToFitWidth = true
        contraseñaTextField.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0/255, alpha: 0.3), NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 16)!])
        contraseñaTextField.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(imageViewIconoCandado.snp.bottom)
            maker.leading.equalTo(imageViewIconoCandado.snp.trailing).offset(10)
            maker.height.equalTo(mailTextField.snp.height)
            maker.trailing.equalToSuperview().inset(30)
        }
        
        //UIView para linea2
        viewBlanca.addSubview(linea2)
        linea2.translatesAutoresizingMaskIntoConstraints = false
        linea2.backgroundColor = colorWithHexString(hexString: azulOscuro)
        linea2.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.top.equalTo(contraseñaTextField.snp.bottom).offset(10)
            maker.leading.equalTo(imageViewIconoCandado.snp.leading)
            maker.trailing.equalTo(contraseñaTextField.snp.trailing)
        }
        
        //UIButton para 'Iniciar sesión'
        viewBlanca.addSubview(iniciarSesionButton)
        iniciarSesionButton.translatesAutoresizingMaskIntoConstraints = false
        iniciarSesionButton.setTitle("Iniciar sesión", for: .normal)
        iniciarSesionButton.setTitleColor(.white, for: .normal)
        iniciarSesionButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        iniciarSesionButton.backgroundColor = colorWithHexString(hexString: celeste)
        iniciarSesionButton.layer.cornerRadius = 15
        iniciarSesionButton.layer.shadowColor = UIColor(red: 6/255, green: 22/255, blue: 52/255, alpha: 0.3).cgColor //Color sombra (azulOscuro en RGB)
        iniciarSesionButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0) //Posicion sombra
        iniciarSesionButton.layer.shadowOpacity = 1 //Opacidad sombra
        iniciarSesionButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(46)
            maker.top.equalTo(linea2.snp.bottom).offset(30)
            maker.leading.equalTo(imageViewIconoCandado.snp.leading)
            maker.trailing.equalTo(linea2.snp.trailing)
        }
        
        //UIButton para 'Olvidé mi contraseña'
        viewBlanca.addSubview(olvidarContraseñaButton)
        olvidarContraseñaButton.translatesAutoresizingMaskIntoConstraints = false
        olvidarContraseñaButton.setTitle("Olvidé mi contraseña", for: .normal)
        olvidarContraseñaButton.setTitleColor(colorWithHexString(hexString: celeste), for: .normal)
        olvidarContraseñaButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        olvidarContraseñaButton.backgroundColor = .white
        olvidarContraseñaButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.top.equalTo(iniciarSesionButton.snp.bottom).offset(20)
            maker.leading.equalTo(iniciarSesionButton.snp.leading)
            maker.trailing.equalTo(iniciarSesionButton.snp.trailing)
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

