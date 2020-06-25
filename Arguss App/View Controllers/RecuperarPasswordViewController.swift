import UIKit
import Firebase

@available(iOS 13.0, *)
class RecuperarPasswordViewController: UIViewController {

    //MARK: ATRIBUTOS
    let vista = RecuperarPasswordView()
    let activityIndicator = ActivityIndicator() //Instancia del Activity Indicator
    let alertas = Alertas()
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mostrar navigationBar
        self.navigationController?.isNavigationBarHidden = false
        
        //Mostrar objetos de la vista
        vista.mostrarVista(viewController: self)
        
        //Configuracion cerrarVistaBarButton
        let cerrarVistaBarButton = UIBarButtonItem(image: UIImage(named: "cruz_cerrar"), style: .plain, target: self, action: #selector(cerrarVistaButtonTapped))
        self.navigationItem.leftBarButtonItem = cerrarVistaBarButton
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
        //Metodo para ocultar teclado
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        //Metodo para cambiar colores al tocar el mailTextField
        vista.mailTextField.addTarget(self, action: #selector(mailTextFieldDidChange), for: .touchDown)
        
        //Metodo a ejecutar al presionar el boton 'Continuar'
        vista.continuarButton.addTarget(self, action: #selector(continuarButtonTapped), for: .touchUpInside)
    }
    
    //MARK: viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Mostrar navigationBar
        self.navigationController?.isNavigationBarHidden = false
        
        //Mostrar objetos de la vista
        vista.mostrarVista(viewController: self)
        vista.mailTextField.text = ""
    }
    
    //MARK: METODOS PARA CONFIGURACIONES VISUALES
    // Función para ocultar teclado
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        self.volverMailColorOriginal()
    }
    
    //Funcion para volver el imageViewIconoSobre y la linea1 al color azulOscuro
    func volverMailColorOriginal() {
        vista.imageViewIconoSobre.tintColor = vista.colorWithHexString(hexString: vista.azulOscuro)
        vista.linea.backgroundColor = vista.colorWithHexString(hexString: vista.azulOscuro)
    }
    
    //Funcion para cambiar colores cuando se selecciona el mailTextField
    @objc public func mailTextFieldDidChange(textField: UITextField) {
        vista.imageViewIconoSobre.tintColor = vista.colorWithHexString(hexString: vista.celeste)
        vista.linea.backgroundColor = vista.colorWithHexString(hexString: vista.celeste)
    }
    
    @objc func cerrarVistaButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc public func continuarButtonTapped(sender: UIButton!) {
        activityIndicator.empezarActivityIndicator(viewController: self)
        
        if vista.mailTextField.text != "" {
            guard let mail = vista.mailTextField.text else { return }
            Auth.auth().sendPasswordReset(withEmail: mail) { (error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error al enviar mail", error.localizedDescription)
                        let alerta = UIAlertController(title: "Atención", message: "Se ha producido un error al enviar el correo electrónico de recuperación de contraseña. Por favor, intente nuevamente", preferredStyle: .alert)
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                        self.activityIndicator.terminarActivityIndicator(viewController: self)
                        self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
                    } else {
                        let alerta = UIAlertController(title: "Verificación", message: "Se le ha enviado un correo electrónico a la cuenta indicada. Por favor, verifíquelo y siga las instrucciones.", preferredStyle: .alert)
                        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { (alertAction) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.activityIndicator.terminarActivityIndicator(viewController: self)
                        self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
                        print("Se envió el mail correctamente")
                    }
                }
            }
        } else {
            let alerta = UIAlertController(title: "Atención", message: "El campo de correo electrónico no debe estar vacío", preferredStyle: .alert)
            let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            activityIndicator.terminarActivityIndicator(viewController: self)
            self.alertas.presentarAlerta(alerta: alerta, acciones: [aceptar], vc: self)
        }
    }
}
