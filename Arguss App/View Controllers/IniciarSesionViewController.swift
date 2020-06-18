import UIKit

@available(iOS 13.0, *)
class IniciarSesionViewController: UIViewController {

    //MARK: ATRIBUTOS
    let vista = IniciarSesionView() //Instancia de la vista
    let activityIndicator = ActivityIndicator() //Instancia del Activity Indicator
    
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
        
        // Metodos para levantar-bajar vista al mostrar-ocultar teclado
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: viewDidAppear()
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    // Función para bajar vista al ocultar teclado
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //MARK: METODOS PARA FUNCIONAMIENTO DEL SISTEMA

}
