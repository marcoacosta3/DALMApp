//
//  ViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 28/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Frameworks y librerías
import UIKit
import Alamofire
import UserNotifications

//Define la clase y protocolos de textfield y notificaciones
class ViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
    //Outlets de textfields para número de dispositivo y contraseña, y de botón de conectar
    @IBOutlet weak var numeroDeDispositivoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //    var usuario: String = ""
    
    //Método que mostrará el navigationbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    //Método que desaparecerá el navigationbar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Asignación de los delegados de notificaciones y textfield
        UNUserNotificationCenter.current().delegate = self
        numeroDeDispositivoTextField.delegate = self
        passwordTextField.delegate = self
        
        //Identifica a los textfield con un número de etiqueta
        numeroDeDispositivoTextField.tag = 0
        passwordTextField.tag = 1
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 3
    }
    
    //Método para pasar al siguiente textfield cuando termina de escribir
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
    
    
    //Action del botón de conectar
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        //Corroboración de que se asignaron el número de dispositivo y contraseña, y que no esten en blanco
        guard
            let user = numeroDeDispositivoTextField.text, user != "",
            let password = passwordTextField.text, password != ""
            else {
                displayAlert()
                return
        }
        
        print(user)
        print(password)
        //Llamado de la función de login
        loginRest(user: user, password: password)
        
        //Llamado de las funciones de notificaciones
        sendDailyNotification()
        sendDailyCheckFoodLevelNotification()
    }
    
    //Método de alerta de campos vacíos
    func displayAlert() {
        //Crea la alerta
        let alert = UIAlertController(title: "Campos Vacíos", message: "El número de dispositivo y contraseña son requeridos.", preferredStyle: .alert)
        //Agrega la acción a la alerta
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("El \"Aceptar\" ocurrio de alerta.")
        }))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
    
    //Método de alerta de número de dispositivo o contraseña incorrecto
    func displayAlertError() {
        //Crea la alerta
        let alert = UIAlertController(title: "Error", message: "Número de dispositivo o contraseña incorrecto.", preferredStyle: .alert)
        //Agrega la acción a la alerta
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("El \"Aceptar\" ocurrio de alerta.")
        }))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
    
    //Método para hacer login, recibe el número de dispositivo y contraseña
    func loginRest(user: String, password: String){
        
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/conexion.php"
        //Parámetros de la petición al webservice
        let parameters = ["dispositivo": user, "claveAcceso": password]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"] //application/x-www-form-urlencoded
        
        //Método de la petición al webservice, respuesta decodificada de tipo Usuario
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: Usuario.self) {[weak self] (response) in
            print(response.result)
            
            //Evalúa el caso de que sea éxitoso o no el login
            switch response.result {
                
            //Caso exitoso envía el token del usuario
            case .success(_):
                
                guard let usuario = response.value else { return }
                self?.performSegue(withIdentifier: "LoginToMenuPrincipal", sender: usuario.token)
                break
            //Caso de fallido muestra alerta de error
            case .failure( _):
                self?.displayAlertError()
                break
            }
        }
    }
    
    //Método que envia notificación de limpliar platos
    func sendDailyNotification(){
        
        //Hora y minuto de envio de notificación
        var date = DateComponents()
        date.hour = 20
        date.minute = 00
        
        //Disparador de la notificación
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        //Crea el contenido de la notificación
        let content = UNMutableNotificationContent()
        content.title = "Limpiar platos"
        content.subtitle = "¿Platos sucios?"
        content.body = "Recuerda limpiar los platos del alimento y el agua."
        content.sound = UNNotificationSound.default
        
        //Crea la solicitud
        let request = UNNotificationRequest(identifier: "CleanNotification", content: content, trigger: trigger)
        
        //Añade la solicitud al centro de notificaciones
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Se ha producido un error: \(error)")
            }
        }
    }
    
    //Método que envia notificación de revisar nivel de alimento
    func sendDailyCheckFoodLevelNotification() {
        
        //Hora y minuto de envio de notificación
        var date = DateComponents()
        date.hour = 21
        date.minute = 00
        
        //Disparador de la notificación
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        //Crea el contenido de la notificación
        let content = UNMutableNotificationContent()
        content.title = "¡Revisar nivel de alimento!"
        content.subtitle = "¿Todavía hay suficiente alimento?"
        content.body = "Recuerda revisar el nivel del alimento del contenedor."
        content.sound = UNNotificationSound.default
        
        //Crea la solicitud
        let request = UNNotificationRequest(identifier: "foodLevelNotification", content: content, trigger: trigger)
        
        //Añade la solicitud al centro de notificaciones
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Se ha producido un error: \(error)")
            }
        }
    }
    
    //Método del centro de notificaciones
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    //Método para preparar segue 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let menuPrincipalVC = segue.destination as? MenuPrincipalViewController, let usuario = sender as? String{
            menuPrincipalVC.usuario = usuario
        }
        //                    if let identifier = segue.identifier, identifier == "LoginToMenuPrincipal" {
        //                        guard let menuPrincipalVC = segue.destination as? MenuPrincipalViewController else {
        //                            return
        //                        }
        //                        menuPrincipalVC.usuario = self.usuario
        //                    }
    }
    
}

