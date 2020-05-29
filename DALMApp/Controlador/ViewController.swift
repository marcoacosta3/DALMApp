//
//  ViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 28/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var numeroDeDispositivoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numeroDeDispositivoTextField.delegate = self
        passwordTextField.delegate = self
        
        numeroDeDispositivoTextField.tag = 0
        passwordTextField.tag = 1
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 3
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
               nextField.becomeFirstResponder()
                textField.endEditing(true)
                print(textField.text!)
            } else {
               textField.resignFirstResponder()
            }
            return false
        }
    
    
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
                guard
                    let user = numeroDeDispositivoTextField.text,
                    let password = passwordTextField.text
                    else { return }
                print(user)
                print(password)
                
                
                if user == "" || password == "" {
                    displayAlert()
                }else{

                    loginRest(user: user, password: password)
                }
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "Campos Vacíos", message: "El número de dispositivo y contraseña son requeridos.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"Aceptar\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

        func loginRest(user: String, password: String){

            let url = "http://n-systems-mx.com/tta069/controlador/conexion.php"
            let parameters = ["dispositivo": user, "claveAcceso": password]

            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

            AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: Usuario.self) {[weak self] (response) in
                print(response.result)
                switch response.result {

                case .success(_):
                    
                    guard let usuario = response.value else { return }
                    self?.performSegue(withIdentifier: "LoginToMenuPrincipal", sender: usuario.token)
                    break
                case .failure( _):
                   let alertController = UIAlertController(title: "Error", message: "Número de dispositivo o contraseña incorrecto", preferredStyle: .alert)
                   
                   let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                   alertController.addAction(defaultAction)
                   
                   self?.present(alertController, animated: true, completion: nil)
                    break
                }
            }
        }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let menuPrincipalVC = segue.destination as? MenuPrincipalViewController, let usuario = sender as? String{
                menuPrincipalVC.usuario = usuario
            }
    //        if let identifier = segue.identifier, identifier == "LoginToMenuPrincipal" {
    //            guard let menuPrincipalVC = segue.destination as? MenuPrincipalViewController else {
    //                return
    //            }
    //            menuPrincipalVC.usuario = usuario
    //        }
        }

}

