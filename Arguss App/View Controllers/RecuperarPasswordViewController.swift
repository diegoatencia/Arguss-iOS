import UIKit

@available(iOS 13.0, *)
class RecuperarPasswordViewController: UIViewController {

    //MARK: ATRIBUTOS
    let vista = RecuperarPasswordView()
    
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
    }
    
    //MARK: viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Mostrar navigationBar
        self.navigationController?.isNavigationBarHidden = false
        
        //Mostrar objetos de la vista
        vista.mostrarVista(viewController: self)
    }
    
    @objc func cerrarVistaButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
