import Foundation
import Firebase

class IniciarSesionServicio {
    
    //MARK: ATRIBUTOS
    var db: Firestore?
    
    func iniciarSesion(mail: String, contraseña: String) -> String {
        
        var resultado: String = ""
        print("ingresó a metodo del servicio")
        
        Auth.auth().signIn(withEmail: mail, password: contraseña) { (result, error) in
            
            print("Se entró a metodo de sign in de firebase")
            
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .wrongPassword:
                        print("Contraseña incorrecta")
                        resultado = "contraseña_incorrecta"
                    default:
                        print("Error: \(error!)")
                        resultado = "otro_error"
                    }
                }
            } else {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                
                //Busqueda entre los usuarios de Firestore para ver si es administrador o no
                self.db!.collection("users").getDocuments { (snapshot, error) in
                    
                    print("buscando usuarios en db")
                    
                    if let error = error { //Si se produce un error obteniendo los datos
                        print("Error obteniendo los documentos de Firestore: ", error.localizedDescription)
                        resultado = "otro_error"
                    } else {
                        //Recorrer los documentos encontrados
                        for document in snapshot!.documents {
                            let values = document.data()
                            let id = document.documentID
                            
                            if id == userId {
                                let isAdmin = values["isAdmin"] as! Bool
                                
                                print("isAdmin: ", isAdmin)
                                if isAdmin == true {
                                    print("inicio admin servicio")
                                    resultado = "inicio_admin"
                                } else {
                                    print("inicio usuario servicio")
                                    resultado = "inicio_usuario"
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return resultado
    }
    
}
