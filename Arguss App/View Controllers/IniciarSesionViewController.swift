import UIKit
import Firebase

@available(iOS 13.0, *)
class IniciarSesionViewController: UIViewController {
    
    //MARK: ATRIBUTOS
    let vista = IniciarSesionView() //Instancia de la vista
    let activityIndicator = ActivityIndicator() //Instancia del Activity Indicator
    let alertas = Alertas()
    var db: Firestore!
    
    let homeAdmin = HomeAdminViewController()
    let homeUser = HomeUsuarioViewController()
    let recuperarContraseñaVC = RecuperarPasswordViewController()
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ocultar navigationBar
        self.navigationController?.isNavigationBarHidden = true
        
        //Mostrar objetos de la vista
        vista.mostrarVista(viewController: self)
        
        //Metodo para ocultar teclado
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        //Metodo para cambiar colores al tocar el mailTextField
        vista.mailTextField.addTarget(self, action: #selector(mailTextFieldDidChange), for: .touchDown)
        
        //Metodo para cambiar colores al tocar el contraseñaTextField
        vista.contraseñaTextField.addTarget(self, action: #selector(contraseñaTextFieldDidChange), for: .touchDown)
        
        //Metodos para levantar-bajar vista al mostrar-ocultar teclado
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Instancia de Firestore
        db = Firestore.firestore()
        
        //Métodos a ejecutar al tocar los botones
        //Boton 'Iniciar sesion'
        vista.iniciarSesionButton.addTarget(self, action: #selector(iniciarSesionButtonTapped), for: .touchUpInside)
        //Boton 'Olvidé mi contraseña'
        vista.olvidarContraseñaButton.addTarget(self, action: #selector(olvidarContraseñaButtonTapped), for: .touchUpInside)
    }
    
    //MARK: viewDidAppear()
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        /* HABILITAR DESPUES, CUANDO ESTÉ TODO EL LOGIN HECHO */
        //sesionActiva()
        
        self.vaciarTextFields()
    }
    
    //MARK: viewWillAppear()
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        self.vaciarTextFields()
    }
    
    //MARK: didReceiveMemoryWarning()
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: METODOS PARA CONFIGURACIONES VISUALES
    // Función para ocultar teclado
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        self.volverMailColorOriginal()
        self.volverContraseñaColorOriginal()
    }
    
    //Funcion para cambiar colores cuando se selecciona el mailTextField
    @objc public func mailTextFieldDidChange(textField: UITextField) {
        vista.imageViewIconoSobre.tintColor = vista.colorWithHexString(hexString: vista.celeste)
        vista.linea1.backgroundColor = vista.colorWithHexString(hexString: vista.celeste)
        self.volverContraseñaColorOriginal()
    }
    
    //Funcion para cambiar colores cuando se selecciona el contraseñaTextField
    @objc public func contraseñaTextFieldDidChange(textField: UITextField) {
        vista.imageViewIconoCandado.tintColor = vista.colorWithHexString(hexString: vista.celeste)
        vista.linea2.backgroundColor = vista.colorWithHexString(hexString: vista.celeste)
        self.volverMailColorOriginal()
    }
    
    //Funcion para volver el imageViewIconoSobre y la linea1 al color azulOscuro
    func volverMailColorOriginal() {
        vista.imageViewIconoSobre.tintColor = vista.colorWithHexString(hexString: vista.azulOscuro)
        vista.linea1.backgroundColor = vista.colorWithHexString(hexString: vista.azulOscuro)
    }
    
    //Funcion para volver el imageViewIconoCandado y la linea2 al color azulOscuro
    func volverContraseñaColorOriginal() {
        vista.imageViewIconoCandado.tintColor = vista.colorWithHexString(hexString: vista.azulOscuro)
        vista.linea2.backgroundColor = vista.colorWithHexString(hexString: vista.azulOscuro)
    }
    
    //Funcion para vaciar textFields
    func vaciarTextFields() {
        self.vista.mailTextField.text = ""
        self.vista.contraseñaTextField.text = ""
    }
    
    //Funcion para vaciar mailTextField
    func vaciarMailTextField() {
        self.vista.mailTextField.text = ""
    }
    
    //Funcion para vaciar contraseñaTextField
    func vaciarContraseñaTextField() {
        self.vista.contraseñaTextField.text = ""
    }
    
    // Función para levantar vista al mostrar teclado
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var reduccionAltura: CGFloat = 0
        switch vista.alturaIphones {
        case 1334:
            reduccionAltura = 26
        case 1920:
            reduccionAltura = 30
        case 2436:
            reduccionAltura = 80
        default:
            reduccionAltura = 70
        }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height - reduccionAltura
        }
    }

    // Función para bajar vista al ocultar teclado
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: METODOS PARA FUNCIONAMIENTO DEL SISTEMA
    // Metodo al presionar el boton 'Iniciar sesion'
    @objc public func iniciarSesionButtonTapped(sender: UIButton!){
        print("Botón iniciar sesión presionado. Ingresando...")
        
        activityIndicator.empezarActivityIndicator(viewController: self)
        
        if vista.mailTextField.text != "" && vista.contraseñaTextField.text != "" {
            //Condicion: textFields llenos
            
            guard let mail = vista.mailTextField.text else { return }
            guard let contraseña = vista.contraseñaTextField.text else { return }
            self.inicio(mail: mail, contraseña: contraseña)
            
        } else if vista.mailTextField.text == "" && vista.contraseñaTextField.text == "" {
            //Condicion: textFields vacíos
            
            let alerta = UIAlertController(title: "Atención", message: "Los campos de correo electrónico y contraseña no deben estar vacíos.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        } else if vista.mailTextField.text == "" && vista.contraseñaTextField.text != "" {
            //Condicion: mailTextField vacío
            
            let alerta = UIAlertController(title: "Atención", message: "El campo de email no debe estar vacío.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.vaciarContraseñaTextField()
            activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        } else if vista.mailTextField.text != "" && vista.contraseñaTextField.text == "" {
            //Condicion: contraseñaTextField vacío
            
            let alerta = UIAlertController(title: "Atención", message: "El campo de contraseña no debe estar vacío.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
        }
    }
    
    func inicio(mail: String, contraseña: String){
        Auth.auth().signIn(withEmail: mail, password: contraseña) { (result, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .wrongPassword:
                        print("Contraseña incorrecta")
                        self.iniciarSesion(tipoInicio: "contraseña_incorrecta")
                    default:
                        print("Error: \(error!)")
                        self.iniciarSesion(tipoInicio: "otro_error")
                    }
                }
            } else {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                
                //Busqueda entre los usuarios de Firestore para ver si es administrador o no
                self.db.collection("users").getDocuments { (snapshot, error) in
                    if let error = error { //Si se produce un error obteniendo los datos
                        print("Error obteniendo los documentos de Firestore: ", error.localizedDescription)
                        self.iniciarSesion(tipoInicio: "otro_error")
                    } else {
                        //Recorrer los documentos encontrados
                        for document in snapshot!.documents {
                            let values = document.data()
                            let id = document.documentID
                            
                            if id == userId {
                                let isAdmin = values["isAdmin"] as! Bool
                                if isAdmin == true {
                                    self.iniciarSesion(tipoInicio: "inicio_admin")
                                } else {
                                    self.iniciarSesion(tipoInicio: "inicio_usuario")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func iniciarSesion(tipoInicio: String) {
        switch tipoInicio {
        case "no_usuario":
            let alerta = UIAlertController(title: "Usuario no encontrado", message: "No se encontró un usuario registrado con los datos ingresados.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.vaciarTextFields()
            self.activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        case "contraseña_incorrecta":
            let alerta = UIAlertController(title: "Contraseña incorrecta", message: "La contraseña ingresada no es válida. Ingresela nuevamente.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.vaciarContraseñaTextField()
            self.activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        case "otro_error", "":
            let alerta = UIAlertController(title: "Atención", message: "No se ha podido iniciar sesión. Intente nuevamente", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.vaciarTextFields()
            self.activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        case "inicio_admin":
            self.activityIndicator.terminarActivityIndicator(viewController: self)
            self.navigationController?.pushViewController(self.homeAdmin, animated: true)
            
        default:
            self.activityIndicator.terminarActivityIndicator(viewController: self)
            self.navigationController?.pushViewController(self.homeUser, animated: true)
        }
    }
    
    @objc public func olvidarContraseñaButtonTapped(sender: UIButton!) {
        self.navigationController?.pushViewController(self.recuperarContraseñaVC, animated: true)
    }
    
}
