//
//  HorarioViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire

//Define la clase y los protocolos de textfield y picker
class HorarioViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
    //Outlets de los textfield, picker, label, botones
    @IBOutlet weak var suggestedScheduleSwitch: UISwitch!
    @IBOutlet weak var choiceScheduleSwitch: UISwitch!
    @IBOutlet weak var suggestedTextView: UITextView!
    @IBOutlet weak var suggestedDayScheduleTextField: UITextField!
    @IBOutlet weak var suggestedHourScheduleTextField: UITextField!
    @IBOutlet weak var suggestedPortionScheduleTextField: UITextField!
    @IBOutlet weak var personalizedDayTextField: UITextField!
    @IBOutlet weak var personalizedPortionFoodTextField: UITextField!
    @IBOutlet weak var personalizedHourTextField: UITextField!
    @IBOutlet weak var suggestedDayScheduleLabel: UILabel!
    @IBOutlet weak var suggestedHourScheduleLabel: UILabel!
    @IBOutlet weak var suggestedPortionScheduleLabel: UILabel!
    @IBOutlet weak var personalizedDayLabel: UILabel!
    @IBOutlet weak var personalizedPortionFoodLabel: UILabel!
    @IBOutlet weak var personalizedHourLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    //Variables usuario para token y campos de horario sugerido que se guardarán
    var usuario: String = ""
    //var suggestedHourSaved: [String] = []//String = ""
    var suggestedPortionFoodSaved: Int = 0
    var suggestedHourSaved: String = ""
    
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
        
        //Asignación de los delegados de textfield
        personalizedDayTextField.delegate = self
        personalizedPortionFoodTextField.delegate = self
        personalizedHourTextField.delegate = self
        
        //Deshabilita el uso de los campos de horario sugerido
        suggestedDayScheduleTextField.isEnabled = false
        suggestedHourScheduleTextField.isEnabled = false
        suggestedPortionScheduleTextField.isEnabled = false
        
        //Deshabilita el uso de los campos de horario personalizado
        personalizedDayTextField.isEnabled = false
        personalizedPortionFoodTextField.isEnabled = false
        personalizedHourTextField.isEnabled = false
        
        //Transparencia de opciones de horario personalizado
        personalizedDayLabel.alpha = 0.5
        personalizedPortionFoodLabel.alpha = 0.5
        personalizedHourLabel.alpha = 0.5
        personalizedDayTextField.alpha = 0.5
        personalizedPortionFoodTextField.alpha = 0.5
        personalizedHourTextField.alpha = 0.5
        
        //Enciende switch de horario sugerido
        suggestedScheduleSwitch.isOn = true
        suggestedScheduleSwitch.setOn(true, animated: false)
        suggestedScheduleSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        self.view!.addSubview(suggestedScheduleSwitch)
        
        //Apaga switch de horario personalizado y deshabilita activación
        choiceScheduleSwitch.isUserInteractionEnabled = false
        choiceScheduleSwitch.alpha = 0.5
        choiceScheduleSwitch.isOn = false
        choiceScheduleSwitch.setOn(false, animated: false)
        choiceScheduleSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        self.view!.addSubview(choiceScheduleSwitch)
        
        //Diseño de botones
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 3
        mainMenuButton.layer.cornerRadius = mainMenuButton.frame.size.height / 3
        print(usuario + " Horario")
        
        suggestedTextView.layer.cornerRadius = suggestedTextView.frame.size.height / 5
        scheduleGeneratedRest(usuario: usuario)
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
    
    @objc func action() {
        view.endEditing(true)
    }
    
    //    @IBAction func switchValueDidChange(_ sender: UISwitch) {
    //    }
    
    //Método para evaluar que switch esta activado, habilita y deshabilita el tipo de horario
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn == true){
            print("on")
            if sender.tag == 1 {
                enabledSuggestedScheduleDisabledChoiceSchedule()
            }else {
                enabledChoiceScheduleDisabledSuggestedSchedule()
            }
            
        }else{
            print("off")
            if sender.tag == 1 {
                enabledChoiceScheduleDisabledSuggestedSchedule()
            }else{
                enabledSuggestedScheduleDisabledChoiceSchedule()
            }
        }
    }
    
    //Método para habilitar los campos de horario sugerido y deshabilitar campos de horario personalizado
    func enabledSuggestedScheduleDisabledChoiceSchedule() {
        
        choiceScheduleSwitch.alpha = 0.5
        choiceScheduleSwitch.isUserInteractionEnabled = false
        choiceScheduleSwitch.setOn(false, animated: false)
        scheduleGeneratedRest(usuario: usuario)
        
        personalizedDayTextField.isEnabled = false
        personalizedDayTextField.alpha = 0.5
        personalizedDayTextField.text = ""
        personalizedDayTextField.placeholder = "Día"
        personalizedPortionFoodTextField.isEnabled = false
        personalizedPortionFoodTextField.alpha = 0.5
        personalizedPortionFoodTextField.text = ""
        personalizedPortionFoodTextField.placeholder = "En gramos (p. ej. 250)"
        personalizedHourTextField.isEnabled = false
        personalizedHourTextField.alpha = 0.5
        personalizedHourTextField.text = ""
        personalizedHourTextField.placeholder = "Formato hh:mm en 24 hrs (p. ej. 9:00,18:00)"
        personalizedDayLabel.alpha = 0.5
        personalizedPortionFoodLabel.alpha = 0.5
        personalizedHourLabel.alpha = 0.5
        
        suggestedScheduleSwitch.alpha = 1
        suggestedScheduleSwitch.isUserInteractionEnabled = true
        suggestedScheduleSwitch.setOn(true, animated: false)
        
        suggestedTextView.alpha = 1
        suggestedDayScheduleLabel.alpha = 1
        suggestedHourScheduleLabel.alpha = 1
        suggestedPortionScheduleLabel.alpha = 1
        suggestedDayScheduleTextField.alpha = 1
        suggestedHourScheduleTextField.alpha = 1
        suggestedPortionScheduleTextField.alpha = 1
        
    }
    
    //Método para habilitar los campos de horario personalizado y deshabilitar campos de horario sugerido
    func enabledChoiceScheduleDisabledSuggestedSchedule() {
        
        choiceScheduleSwitch.alpha = 1
        choiceScheduleSwitch.isUserInteractionEnabled = true
        choiceScheduleSwitch.setOn(true, animated: false)
        schedulePersonalizedEditRest(token: usuario)
        
        personalizedDayTextField.isEnabled = false
        personalizedDayTextField.alpha = 1.0
        personalizedDayTextField.text = "Lunes a Domingo"
        personalizedPortionFoodTextField.isEnabled = true
        personalizedPortionFoodTextField.alpha = 1.0
        personalizedHourTextField.isEnabled = true
        personalizedHourTextField.alpha = 1.0
        personalizedDayLabel.alpha = 1.0
        personalizedPortionFoodLabel.alpha = 1.0
        personalizedHourLabel.alpha = 1.0
        
        suggestedScheduleSwitch.setOn(false, animated: false)
        suggestedScheduleSwitch.alpha = 0.5
        suggestedScheduleSwitch.isUserInteractionEnabled = false
        
        suggestedTextView.alpha = 0.5
        suggestedDayScheduleLabel.alpha = 0.5
        suggestedHourScheduleLabel.alpha = 0.5
        suggestedPortionScheduleLabel.alpha = 0.5
        suggestedDayScheduleTextField.alpha = 0.5
        suggestedHourScheduleTextField.alpha = 0.5
        suggestedPortionScheduleTextField.alpha = 0.5
        suggestedTextView.isUserInteractionEnabled = false
        suggestedDayScheduleTextField.isUserInteractionEnabled = false
        suggestedHourScheduleTextField.isUserInteractionEnabled = false
        suggestedPortionScheduleTextField.isUserInteractionEnabled = false
        suggestedDayScheduleTextField.text = ""
        suggestedHourScheduleTextField.text = ""
        suggestedPortionScheduleTextField.text = ""
        suggestedDayScheduleTextField.placeholder = "Día"
        suggestedPortionScheduleTextField.placeholder = "Poción"
        suggestedHourScheduleTextField.placeholder = "Hora"
        
    }
    
    //Action de botón para guardar el horario
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        
        //Caso para guardar horario sugerido
        if suggestedScheduleSwitch.isOn || suggestedScheduleSwitch.alpha == 1 {
            
            //            schedulePersonalizedRest(token: usuario, domingo: suggestedHourSaved, lunes: suggestedHourSaved, martes: suggestedHourSaved, miercoles: suggestedHourSaved, jueves: suggestedHourSaved, viernes: suggestedHourSaved, sabado: suggestedHourSaved, gramos: Int(suggestedPortionFoodSaved))
            //let hourTextS = suggestedHourScheduleTextField.text!
            schedulePersonalizedRest(token: usuario, domingo: suggestedHourSaved + ",", lunes: suggestedHourSaved + ",", martes: suggestedHourSaved + ",", miercoles: suggestedHourSaved + ",", jueves: suggestedHourSaved + ",", viernes: suggestedHourSaved + ",", sabado: suggestedHourSaved + ",", gramos: String(suggestedPortionFoodSaved))
            displayAlertSaved()
        }else {
            //            let hourText: String = personalizedHourTextField.text!
            //            let hourA = hourText.components(separatedBy: ", ")
            //            print(hourA)
            //            schedulePersonalizedRest(token: usuario, domingo: hourA, lunes: hourA, martes: hourA, miercoles: hourA, jueves: hourA, viernes: hourA, sabado: hourA, gramos: personalizedPortionFoodTextField.text!)
            //            displayAlertSaved()
            //Caso para horario personalizado
            let hourTextP = personalizedHourTextField.text!
            schedulePersonalizedRest(token: usuario, domingo: hourTextP + ",", lunes:  hourTextP + ",", martes:  hourTextP + ",", miercoles:  hourTextP + ",", jueves:  hourTextP + ",", viernes:  hourTextP + ",", sabado:  hourTextP + ",", gramos: personalizedPortionFoodTextField.text!)
//            displayAlertSaved()
        }
        sendDailyFoodNotification()
    }
    
    //Método de alerta muestra mensaje de guardado
    func displayAlertSaved() {
        //Crea la alerta
        let alert = UIAlertController(title: "Configuración Guardada", message: "La configuración se ha guardado exitosamente.", preferredStyle: .alert)
        //Agrega la acción a la alerta
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("La \"Aceptar\" ocurrio de alerta.")
        }))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlertError() {
        //Crea la alerta
        let alert = UIAlertController(title: "Error", message: "No se ha podido configurar el horario.", preferredStyle: .alert)
        //Agrega la acción a la alerta
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("El \"Aceptar\" ocurrio de alerta.")
        }))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
    
    //Método para obtener horario sugerido
    func scheduleGeneratedRest(usuario: String) {
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/generarHorario.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo Horario
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: Horario.self) { (response) in
            print(response.result)
            
            self.suggestedDayScheduleTextField.text = "L-D"
            let suggestedHourData = response.value?.domingo ?? [""]
            self.suggestedHourScheduleTextField.text = suggestedHourData.joined(separator: ", ")
            self.suggestedPortionScheduleTextField.text = String(response.value?.gramos ?? 0) + "g"
            
            for elementHour in suggestedHourData {
                self.suggestedHourSaved.append(elementHour)
            }
            //            self.suggestedHourSaved = suggestedHourData.joined(separator: ", ")
            self.suggestedHourSaved = suggestedHourData.joined(separator: ",")
            self.suggestedPortionFoodSaved = response.value?.gramos ?? 0
            
        }
    }
    
    //    func schedulePersonalizedRest(token: String, domingo: [String], lunes: [String], martes: [String], miercoles: [String], jueves: [String], viernes: [String], sabado: [String], gramos: Int) {
    //
    //        let url = "http://n-systems-mx.com/tta069/controlador/guardarHorario.php"
    //        let parameters = ["token": token,
    //                          "domingo": domingo,
    //                          "lunes": lunes,
    //                          "martes": martes,
    //                          "miercoles": miercoles,
    //                          "jueves": jueves,
    //                          "viernes": viernes,
    //                          "sabado": sabado,
    //                          "gramos": gramos
    //            ] as [String : Any]
    //
    //        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
    //
    //        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
    //            print(response.result)
    //
    //        }
    //    }
    
    //Método para guardar horario
    func schedulePersonalizedRest(token: String, domingo: String, lunes: String, martes: String, miercoles: String, jueves: String, viernes: String, sabado: String, gramos: String) {
        
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/guardarHorarioAndroid.php"
        //Parámetros de la petición al webservice
        let parameters = ["token"    : token,
                          "domingo"  : domingo,
                          "lunes"    : lunes,
                          "martes"   : martes,
                          "miercoles": miercoles,
                          "jueves"   : jueves,
                          "viernes"  : viernes,
                          "sabado"   : sabado,
                          "gramos"   : gramos
        ]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            print(response.result)
            
            switch response.result {
            case .success(_):
                self.displayAlertSaved()
                break
            case .failure(_):
                self.displayAlertError()
                break
            }
        }
    }
    
    //Método para editar el horario personalizado
    func schedulePersonalizedEditRest(token: String) {
        
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/modificarHorario.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": token]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo ModificarHorario
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: ModificarHorario.self) { (response) in
            print(response.result)
            
            self.personalizedPortionFoodTextField.text = response.value?.gramos ?? ""
            self.personalizedHourTextField.text = response.value?.lunes.joined(separator: ",")
        }
    }
    
    //Método que envia notificación de limpliar platos
    func sendDailyFoodNotification(){
        //let hourN = suggestedHourSaved.dropLast(3)
        let hourPN = personalizedHourTextField.text ?? ""
        let minutePN = personalizedHourTextField.text ?? ""
        //Hora y minuto de envio de notificación
        var date = DateComponents()
        date.hour = Int(hourPN.dropLast(3))
        date.minute = Int(minutePN.dropFirst(3))
        
        //Disparador de la notificación
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        //Crea el contenido de la notificación
        let content = UNMutableNotificationContent()
        content.title = "Hora de servir el alimento"
        content.body = "El alimento se ha dispensado."
        content.sound = UNNotificationSound.default
        
        //Crea la solicitud
        let request = UNNotificationRequest(identifier: "FoodNotification", content: content, trigger: trigger)
        
        //Añade la solicitud al centro de notificaciones
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Se ha producido un error: \(error)")
            }
        }
    }
    
    //Método para preparar segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "MenuPrincipalButtonToMenuPrincipal" {
            guard let menuPrincipalBVC = segue.destination as? MenuPrincipalViewController else {
                return
            }
            menuPrincipalBVC.usuario = self.usuario
        }
    }
    
}
