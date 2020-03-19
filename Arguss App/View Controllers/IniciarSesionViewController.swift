import UIKit
import SnapKit
import Firebase
import Hero

@available(iOS 13.0, *)
class IniciarSesionViewController: UIViewController {

    //MARK: ATRIBUTOS
    var db: Firestore!
    
    let homeAdminVC = HomeAdminViewController()
    let homeUsuarioVC = HomeUsuarioViewController()
    let registroVC = RegistroViewController()
    
    var boxView = UIView()
    let activityView = UIActivityIndicatorView(style: .large)
    let textLabel = UILabel()
    
    let vertStack = UIStackView()
    let vertStack2 = UIStackView()
    let imageView = UIImageView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let inicioSesionButton = UIButton()
    let forgotPasswordButton = UIButton()
    let registrarButton = UIButton()
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        vistaGradiente() /*Funcion para poner gradiente al fondo*/
        configuracionVista() /* Funcion para configurar elementos del view controller */
        
        /* Métodos para que cuando toque en cualquier parte de la pantalla se oculte teclado */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        /* Métodos para levantar-bajar vista al mostrar-ocultar teclado */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        /* Métodos a ejecutar al tocar los botones */
        /* Descriptos en Funciones Lógica Sistema */
        inicioSesionButton.addTarget(self, action: #selector(iniciarSesionButtonTapped), for: .touchUpInside)
        registrarButton.addTarget(self, action: #selector(registrarButtonTapped), for: .touchUpInside)
        
    }
    
    //MARK: viewDidAppear().
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* HABILITAR DESPUES, CUANDO ESTÉ TODO EL LOGIN HECHO */
        //sesionActiva()
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: didReceiveMemoryWarning()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: FUNCIONES UTILIDADES
    /* Función para comprobar si la sesión estaba iniciada */
    func sesionActiva(){
        self.empezarActivityIndicator()
        Auth.auth().addStateDidChangeListener { (auth, error) in
            if error == nil {
                self.terminarActivityIndicator()
                print("No estamos logueados")
            } else {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                self.db.collection("users").getDocuments { (snapshot, error) in
                    
                    if let error = error {
                        
                        print("Error al traer datos: ", error.localizedDescription)
                        
                        let alerta = UIAlertController(title: "Ha ocurrido un problema", message: "Se produjo un problema al conectar con la base de datos. Intente nuevamente", preferredStyle: .alert)
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                        
                        alerta.addAction(aceptar)
                        self.terminarActivityIndicator()
                        self.present(alerta, animated: true, completion: nil)
                        
                    } else {
                        
                        for document in snapshot!.documents {
                            
                            let values = document.data()
                            let id = document.documentID
                            
                            if id == userId {
                                
                                let rol = values["rol"] as? String ?? "otro"
                                
                                if rol == "administrador" {
                                    print("Iniciando sesión administrador...")
                                    self.homeAdminVC.isHeroEnabled = true
                                    self.homeAdminVC.modalPresentationStyle = .fullScreen
                                    self.homeAdminVC.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
                                    self.terminarActivityIndicator()
                                    self.present(self.homeAdminVC, animated: true, completion: nil)
                                } else {
                                    print("Iniciando sesión otro usuario...")
                                    self.homeUsuarioVC.isHeroEnabled = true
                                    self.homeUsuarioVC.modalPresentationStyle = .fullScreen
                                    self.homeUsuarioVC.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
                                    self.terminarActivityIndicator()
                                    self.present(self.homeUsuarioVC, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /* Función para levantar vista al mostrar teclado */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    /* Función para bajar vista al ocultar teclado */
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    /* Función para ocultar teclado */
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    /* Función para mostrar Activity Indicator */
    func empezarActivityIndicator() {
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        self.view.addSubview(boxView)
        
        //Configurar box
        boxView.snp.makeConstraints { (maker) in
            maker.height.width.equalTo(100)
            maker.centerX.equalTo(self.view.frame.size.width/2)
            maker.centerY.equalTo(self.view.frame.size.height/2)
        }
        boxView.backgroundColor = .black
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Configurar spin
        activityView.frame = CGRect(x: 30, y: 15, width: 40, height: 40)
        activityView.snp.makeConstraints { (maker) in
            maker.height.width.equalTo(40)
            maker.top.equalTo(15)
            maker.leading.equalTo(30)
        }
        
        //Configurar texto
        textLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.top.equalTo(60)
            maker.leading.equalTo(10)
        }
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 13)
        textLabel.text = "Cargando..."
        
        //Activar
        self.view.isUserInteractionEnabled = false
        print("Inicio activity indicator")
        activityView.startAnimating()
    }
    
    /* Función para ocultar Activity Indicator */
    func terminarActivityIndicator() {
        print("Fin activity indicator")
        boxView.removeFromSuperview()
        activityView.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    //MARK: FUNCIONES DISEÑO VISTA
    /* Funcion para vista gradiente */
    func vistaGradiente(){
        let gradientLayer = CAGradientLayer()
        let customAzul = UIColor(red: 137/255, green: 177/255, blue: 223/255, alpha: 1)
        gradientLayer.colors = [UIColor.white.cgColor, customAzul.cgColor]
        gradientLayer.frame = view.frame
        
        view.layer.addSublayer(gradientLayer)
    }
    
    /* Funcion para configurar vista */
    func configuracionVista(){
        let screenSize = UIScreen.main.bounds
        
        vertStack.addArrangedSubview(imageView)
        vertStack2.addArrangedSubview(emailTextField)
        vertStack2.addArrangedSubview(passwordTextField)
        vertStack2.addArrangedSubview(inicioSesionButton)
        vertStack2.addArrangedSubview(forgotPasswordButton)
        vertStack.addArrangedSubview(vertStack2)
        vertStack.addArrangedSubview(registrarButton)
        
        self.view.addSubview(vertStack)
        
        //imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "logo_png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { maker in
            maker.height.lessThanOrEqualTo(screenSize.height * 0.4)
            maker.width.lessThanOrEqualTo(screenSize.width * 0.5)
            maker.top.equalToSuperview().inset(15)
        }
        
        //emailTextField
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = UIColor.white
        emailTextField.text = ""
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 4
        emailTextField.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 1).cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        emailTextField.leftView = leftView
        emailTextField.leftViewMode = .always
        emailTextField.autocapitalizationType = .none
        
        //passwordTextField
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.placeholder = "Contraseña"
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.text = ""
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 4
        passwordTextField.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 1).cgColor
        let leftView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        passwordTextField.leftView = leftView2
        passwordTextField.leftViewMode = .always
        
        //inicioSesionButton
        inicioSesionButton.translatesAutoresizingMaskIntoConstraints = false
        inicioSesionButton.setTitle("Iniciar sesión", for: .normal)
        inicioSesionButton.setTitleColor(.white, for: .normal)
        inicioSesionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        inicioSesionButton.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        inicioSesionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inicioSesionButton.backgroundColor = UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 1)
        inicioSesionButton.layer.cornerRadius = 15
        inicioSesionButton.layer.borderWidth = 4
        inicioSesionButton.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 1).cgColor
        
        //forgotPasswordButton
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitle("Olvidé mi contraseña", for: .normal)
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        forgotPasswordButton.tintColor = .white
        
        //registrarButton
        registrarButton.translatesAutoresizingMaskIntoConstraints = false
        registrarButton.setTitle("Registrarse", for: .normal)
        registrarButton.setTitleColor(UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 1), for: .normal)
        registrarButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        registrarButton.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        registrarButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registrarButton.backgroundColor = .white
        registrarButton.layer.cornerRadius = 15
        registrarButton.layer.borderWidth = 4
        registrarButton.layer.borderColor = UIColor(red: 66/255, green: 135/255, blue: 245/255, alpha: 1).cgColor
        
        //vertStack
        vertStack.translatesAutoresizingMaskIntoConstraints = false
        vertStack.axis = NSLayoutConstraint.Axis.vertical
        vertStack.distribution = UIStackView.Distribution.equalSpacing
        vertStack.alignment = UIStackView.Alignment.center
        vertStack.spacing = 15
        vertStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        vertStack.snp.makeConstraints { maker in
            maker.width.equalToSuperview().inset(30)
            maker.height.equalToSuperview().inset(20)
        }
        
        //vertStack2
        vertStack2.translatesAutoresizingMaskIntoConstraints = false
        vertStack2.axis = NSLayoutConstraint.Axis.vertical
        vertStack2.distribution = UIStackView.Distribution.equalSpacing
        vertStack2.alignment = UIStackView.Alignment.center
        vertStack2.spacing = 15
    }
    
    //MARK: FUNCIONES LÓGICA SISTEMA
    @objc func iniciarSesionButtonTapped(sender: UIButton!){
        print("Botón iniciar sesión presionado. Ingresando...")
        self.empezarActivityIndicator()
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            inicioSesion(correo: email, contraseña: password)
            
        } else if emailTextField.text == "" && passwordTextField.text == "" {
            
            let alerta = UIAlertController(title: "Atención", message: "Los campos de email y contraseña no deben estar vacíos", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(aceptar)
            self.terminarActivityIndicator()
            self.present(alerta, animated: true, completion: nil)
            
        } else if emailTextField.text == "" && passwordTextField.text != "" {
            
            let alerta = UIAlertController(title: "Atención", message: "El campo de email no debe estar vacío", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(aceptar)
            self.terminarActivityIndicator()
            self.present(alerta, animated: true, completion: nil)
            
        } else if emailTextField.text != "" && passwordTextField.text == "" {
            
            let alerta = UIAlertController(title: "Atención", message: "El campo de contraseña no debe estar vacío", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(aceptar)
            self.terminarActivityIndicator()
            self.present(alerta, animated: true, completion: nil)
            
        }
        
    }
    
    func inicioSesion(correo: String, contraseña: String){
        Auth.auth().signIn(withEmail: correo, password: contraseña) { (result, error) in
            if result != nil {
                
                guard let userId = Auth.auth().currentUser?.uid else { return }
                self.db.collection("users").getDocuments { (snapshot, error) in
                    
                    if let error = error {
                        
                        print("Error al traer datos: ", error.localizedDescription)
                        
                        let alerta = UIAlertController(title: "Ha ocurrido un problema", message: "Se produjo un problema al conectar con la base de datos. Intente nuevamente", preferredStyle: .alert)
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                        
                        alerta.addAction(aceptar)
                        self.terminarActivityIndicator()
                        self.present(alerta, animated: true, completion: nil)
                        
                    } else {
                        
                        for document in snapshot!.documents {
                            
                            let values = document.data()
                            let id = document.documentID
                            
                            if id == userId {
                                
                                let rol = values["rol"] as? String ?? "otro"
                                
                                if rol == "administrador" {
                                    print("Iniciando sesión administrador...")
                                    self.homeAdminVC.isHeroEnabled = true
                                    self.homeAdminVC.modalPresentationStyle = .fullScreen
                                    self.homeAdminVC.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
                                    self.terminarActivityIndicator()
                                    self.present(self.homeAdminVC, animated: true, completion: nil)
                                } else {
                                    print("Iniciando sesión otro usuario...")
                                    self.homeUsuarioVC.isHeroEnabled = true
                                    self.homeUsuarioVC.modalPresentationStyle = .fullScreen
                                    self.homeUsuarioVC.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
                                    self.terminarActivityIndicator()
                                    self.present(self.homeUsuarioVC, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
            } else {
                print("No se encontró usuario autenticado")
                let alerta = UIAlertController(title: "Usuario no encontrado", message: "No se encontró el usuario ingresado. ¿Desea registrarse?", preferredStyle: .actionSheet)
                
                //Agregar funcionalidad de pasar a la vista de registro
                let registrarse = UIAlertAction(title: "Registrarse", style: .default, handler: nil)
                
                let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
                
                alerta.addAction(registrarse)
                alerta.addAction(cancelar)
                self.terminarActivityIndicator()
                self.present(alerta, animated: true, completion: nil)
            }
        
        }
    }
    
    @objc func registrarButtonTapped(sender: UIButton!){
        self.registroVC.isHeroEnabled = true
        self.registroVC.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .up), dismissing: .cover(direction: .down))
        self.present(self.registroVC, animated: true, completion: nil)
    }
    
    
}
