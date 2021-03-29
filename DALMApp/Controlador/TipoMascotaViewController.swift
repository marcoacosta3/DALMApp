//
//  TipoMascotaViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire

//Define la clase
class TipoMascotaViewController: UIViewController {
    
    //Outlets de los botones
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    
    //Variable usuario para token
    var usuario: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Diseño de los botones
        dogButton.layer.cornerRadius = dogButton.frame.size.height / 3
        catButton.layer.cornerRadius = catButton.frame.size.height / 3
        print(usuario + " Tipo")
        
        //Llamado al método para ver si hay una mascota registrada
        registerAnotherPetRest(usuario: usuario)
    }
    
    //Método que verifica si ya hay una mascota registrada
    func registerAnotherPetRest(usuario: String) {
        
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/modificarPerfil.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo PerfilMascota
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: PerfilMascota.self) { (response) in
            print(response.result)
            
            //Verfica si ya hay una mascota registrada, muestra una alerta
            let registerAnotherPetValidation = response.value?.tipo ?? ""
            print(registerAnotherPetValidation)
            if registerAnotherPetValidation == "1" || registerAnotherPetValidation == "2" {
                self.displayAlertPetAlreadyRegistrated()
            }
        }
    }
    
    //Método de alerta de mascota registrada
    func displayAlertPetAlreadyRegistrated() {
        //Crea la alerta
        let alertController = UIAlertController(title: "Mascota Registrada", message: "Ya tienes una mascota registrada, si registras otra mascota se eliminará el perfil que ya tenias.", preferredStyle: .alert)
        //Crea la acción
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        //Agrega la acción
        alertController.addAction(okAction)
        //Muestra la alerta
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Método para preparar segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "TipoDeMascotaToPerro" {
            guard let perroVC = segue.destination as? PerroViewController else {
                return
            }
            perroVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "TipoDeMascotaToGato" {
            guard let gatoVC = segue.destination as? GatoViewController else {
                return
            }
            gatoVC.usuario = self.usuario
        }
    }
    
}
