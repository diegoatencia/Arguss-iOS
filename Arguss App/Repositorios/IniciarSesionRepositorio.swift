import Foundation
import Firebase

class IniciarSesionRepositorio {
     
    //MARK: ATRIBUTOS
    var db: Firestore?
    
    func obtenerUsuarios() -> [Persona] {
        var personas = [Persona]()
        
        //Busqueda entre los usuarios de Firestore para ver si es administrador o no
        print("Entro a obtenerUsers repo")
        self.db?.collection("users").getDocuments { (snapshot, error) in
            print("entró a buscar a la bbdd")
            if let error = error {
                print("Error obteniendo los documentos de Firestore: ", error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    let values = document.data()
                    let idPersona = document.documentID
                    let nombre = values["nombre"] as? String ?? ""
                    let apellido = values["apellido"] as? String ?? ""
                    let mail = values["mail"] as? String ?? ""
                    let isAdmin = values["isAdmin"] as? Bool ?? false
                    let usuario = Persona(idPersona: idPersona, nombre: nombre, apellido: apellido, mail: mail, isAdmin: isAdmin)
                    personas.append(usuario)
                }
            }
        }
        
        return personas
    }
}
