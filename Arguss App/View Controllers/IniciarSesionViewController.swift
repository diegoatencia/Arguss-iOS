import UIKit
import Firebase

@available(iOS 13.0, *)
class IniciarSesionViewController: UIViewController, IniciarSesionDelegate {
    
    //MARK: ATRIBUTOS
    let vista = IniciarSesionView() //Instancia de la vista
    let activityIndicator = ActivityIndicator() //Instancia del Activity Indicator
    let alertas = Alertas()
    var db: Firestore!
    var presenter: IniciarSesionPresenter!
    
    let homeAdmin = HomeAdminViewController()
    let homeUser = HomeUsuarioViewController()
    
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
        
        //Instancia presenter
        presenter = IniciarSesionPresenter()
        presenter.delegate = self
        
        // Métodos a ejecutar al tocar los botones
        // Boton 'Iniciar sesion'
        vista.iniciarSesionButton.addTarget(self, action: #selector(iniciarSesionButtonTapped), for: .touchUpInside)
    }
    
    //MARK: viewDidAppear()
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        /* HABILITAR DESPUES, CUANDO ESTÉ TODO EL LOGIN HECHO */
        //sesionActiva()
        
        vista.mailTextField.text = ""
        vista.contraseñaTextField.text = ""
    }
    
    //MARK: viewWillAppear()
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        vista.mailTextField.text = ""
        vista.contraseñaTextField.text = ""
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
    
    // Función para levantar vista al mostrar teclado
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height
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
        
        if vista.mailTextField.text != "" && vista.contraseñaTextField.text != "" {
            //Condicion: textFields llenos
            
            guard let mail = vista.mailTextField.text else { return }
            guard let contraseña = vista.contraseñaTextField.text else { return }
            presenter.db = self.db
            print("llamada a metodo del presenter en vc")
            presenter.inicioSesion(mail: mail, contraseña: contraseña) ///Llama al metodo 'inicioSesion' del IniciarSesionPresenter
            
        } else if vista.mailTextField.text == "" && vista.contraseñaTextField.text == "" {
            //Condicion: textFields vacíos
            
            let alerta = UIAlertController(title: "Atención", message: "Los campos de email y contraseña no deben estar vacíos.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        } else if vista.mailTextField.text == "" && vista.contraseñaTextField.text != "" {
            //Condicion: mailTextField vacío
            
            let alerta = UIAlertController(title: "Atención", message: "El campo de email no debe estar vacío.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        } else if vista.mailTextField.text != "" && vista.contraseñaTextField.text == "" {
            //Condicion: contraseñaTextField vacío
            
            let alerta = UIAlertController(title: "Atención", message: "El campo de contraseña no debe estar vacío.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
        }
    }
    
    func iniciarSesion(tipoInicio: String) { ///Recibe lo del protocol del presenter
        switch tipoInicio {
        case "no_usuario":
            let alerta = UIAlertController(title: "Usuario no encontrado", message: "No se encontró un usuario registrado con los datos ingresados.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        case "contraseña_incorrecta":
            let alerta = UIAlertController(title: "Contraseña incorrecta", message: "La contraseña ingresada no es válida. Ingresela nuevamente.", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        case "otro_error", "":
            let alerta = UIAlertController(title: "Atención", message: "No se ha podido iniciar sesión. Intente nuevamente", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
            
        case "inicio_admin":
            print("Inicio admin")
            self.present(self.homeAdmin, animated: true, completion: nil)
            
        default:
            print("Inicio usuario")
            self.present(self.homeUser, animated: true, completion: nil)
        }
    }
    
}
