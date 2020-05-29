//
//  PerroViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire

class PerroViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var petOwnerTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petBreedTextField: UITextField!
    @IBOutlet weak var petGenrePicker: UIPickerView!
    @IBOutlet weak var petGenreTextField: UITextField!
    @IBOutlet weak var petAgePicker: UIPickerView!
    @IBOutlet weak var petAgeTextField: UITextField!
    @IBOutlet weak var petSizePicker: UIPickerView!
    @IBOutlet weak var petSizeTextField: UITextField!
    @IBOutlet weak var petPhysicalActivityPicker: UIPickerView!
    @IBOutlet weak var petPhysicalActivityTextField: UITextField!
    @IBOutlet weak var petSpecialDietPicker: UIPickerView!
    @IBOutlet weak var petSpecialDietTextField: UITextField!
    @IBOutlet weak var petPregnantPicker: UIPickerView!
    @IBOutlet weak var petPregnantTextField: UITextField!
    @IBOutlet weak var petWeightPicker: UIPickerView!
    @IBOutlet weak var petWeightTextField: UITextField!
    @IBOutlet weak var petBreastFeedingPicker: UIPickerView!
    @IBOutlet weak var petBreastFeedingTextField: UITextField!
    @IBOutlet weak var petGenreLabel: UILabel!
    @IBOutlet weak var petPregnantLabel: UILabel!
    @IBOutlet weak var petBreastFeedingLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    var petGenrePickerData: [String] = [String]( )
    var petAgePickerData: [String] = [String]( )
    var petSizePickerData: [String] = [String]( )
    var petPhysicalActivityPickerData: [String] = [String]( )
    var petSpecialDietPickerData: [String] = [String]( )
    var petWeightPickerData: [String] = [String]( )
    var petPregnantPickerData: [String] = [String]( )
    var petBreastfeedingPickerData: [String] = [String]( )
    
    var usuario: String = ""
    var petGenreIndex: String = ""
    var petaAgeIndex: String = ""
    var petSizeIndex: String = ""
    var petPhysicalActivityIndex: String = ""
    var petWeightIndex: String = ""
    
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

        petOwnerTextField.delegate = self
        petNameTextField.delegate = self
        petBreedTextField.delegate = self
        petOwnerTextField.tag = 0
        petNameTextField.tag = 1
        petBreedTextField.tag = 2
        self.petGenrePicker.delegate = self
        self.petGenrePicker.dataSource = self
        self.petAgePicker.delegate = self
        self.petAgePicker.dataSource = self
        self.petSizePicker.delegate = self
        self.petSizePicker.dataSource = self
        self.petWeightPicker.delegate = self
        self.petWeightPicker.dataSource = self
        self.petSpecialDietPicker.delegate = self
        self.petSpecialDietPicker.dataSource = self
        self.petPregnantPicker.delegate = self
        self.petPregnantPicker.dataSource = self
        self.petBreastFeedingPicker.delegate = self
        self.petBreastFeedingPicker.dataSource = self
        self.petPhysicalActivityPicker.delegate = self
        self.petPhysicalActivityPicker.dataSource = self
        
        petGenreTextField.inputView = petGenrePicker
        petGenrePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petAgeTextField.inputView = petAgePicker
        petAgePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petSizeTextField.inputView = petSizePicker
        petSizePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petWeightTextField.inputView = petWeightPicker
        petWeightPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petSpecialDietTextField.inputView = petSpecialDietPicker
        petSpecialDietPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petPregnantTextField.inputView = petPregnantPicker
        petPregnantPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petBreastFeedingTextField.inputView = petBreastFeedingPicker
        petBreastFeedingPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petPhysicalActivityTextField.inputView = petPhysicalActivityPicker
        petPhysicalActivityPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        petGenrePickerData = ["Hembra", "Macho"]
        petAgePickerData = ["Cachorro hasta 10 semanas", "Cachorro de 10 semanas a 6 meses", "Cachorro de 6 hasta 12 meses", "Adulto (De 1 a 5 años)", "Vejez (Mayor a 5 años)"]
        petSizePickerData = ["Mini", "Pequeño", "Mediano", "Grande", "Gigante"]
        petWeightPickerData = ["Menor de 3.5kg", "Entre 3.5-7.5kg", "Entre 7.5-11.5kg", "Entre 11.5-15.5kg", "Entre 15.5-19.5kg", "Entre 19.5-23.5kg", "Entre 23.5-27.5kg", "Entre 27.5-33.5kg", "Entre 33.5-39kg", "Entre 39.5-45.5Kg", "Entre 45.5-50Kg"]
        petSpecialDietPickerData = ["Si", "No"]
        petPregnantPickerData = ["Si", "No"]
        petBreastfeedingPickerData = ["Si", "No"]
        petPhysicalActivityPickerData = ["Baja", "Normal", "Alta"]
        
        petPregnantPicker.isUserInteractionEnabled = false
        petBreastFeedingPicker.isUserInteractionEnabled = false
        petPregnantTextField.isUserInteractionEnabled = false
        petBreastFeedingTextField.isUserInteractionEnabled = false
        
        petPregnantPicker.alpha = 0.01
        petPregnantLabel.alpha = 0.5
        petPregnantTextField.alpha = 0.5
        petBreastFeedingPicker.alpha = 0.01
        petBreastFeedingLabel.alpha = 0.5
        petBreastFeedingTextField.alpha = 0.5
        
        dismissPickerView()
        
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 3
        mainMenuButton.layer.cornerRadius = mainMenuButton.frame.size.height / 3
        //petNameTextField.text = usuario
        print(usuario + "perro")
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
    
    func optionsPetGenre(row:Int) {
        if petGenrePickerData[row] == "Hembra"{
            let petGenreValueSelected = petGenrePickerData[row] as String
            petBreastFeedingPicker.isUserInteractionEnabled = true
            petPregnantPicker.isUserInteractionEnabled = true
            petPregnantTextField.isUserInteractionEnabled = true
            petBreastFeedingTextField.isUserInteractionEnabled = true
            petPregnantLabel.alpha = 1
            petBreastFeedingLabel.alpha = 1
            petPregnantPicker.alpha = 1
            petBreastFeedingPicker.alpha = 1
            petPregnantTextField.alpha = 1
            petBreastFeedingTextField.alpha = 1
            
            petGenreTextField.text = petGenreValueSelected
            
            print(petGenreValueSelected)
            
            petGenreIndex = String(row + 2)
            print(petGenreIndex)
        }else{
            let petGenreValueSelected = petGenrePickerData[row] as String
            petBreastFeedingPicker.isUserInteractionEnabled = false
            petPregnantPicker.isUserInteractionEnabled = false
            petPregnantTextField.isUserInteractionEnabled = false
            petBreastFeedingTextField.isUserInteractionEnabled = false
            petPregnantLabel.alpha = 0.5
            petBreastFeedingLabel.alpha = 0.5
            petPregnantPicker.alpha = 0.01
            petBreastFeedingPicker.alpha = 0.01
            petPregnantTextField.alpha = 0.5
            petBreastFeedingTextField.alpha = 0.5
            
            petGenreTextField.text = petGenreValueSelected
            petPregnantTextField.text = ""
            petBreastFeedingTextField.text = ""
            
            print(petGenreValueSelected)
            
            petGenreIndex = String(row)
            print(petGenreIndex)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            //return petGenrePickerData.count
            if pickerView.tag == 1{
                return petGenrePickerData.count
            }else if pickerView.tag == 2{
                return petAgePickerData.count
            }else if pickerView.tag == 3 {
                return petSizePickerData.count
            }else if pickerView.tag == 4 {
                return petWeightPickerData.count
            }else if pickerView.tag == 5 {
                return petSpecialDietPickerData.count
            }else if pickerView.tag == 6 {
                return petPregnantPickerData.count
            }else if pickerView.tag == 7 {
                return petBreastfeedingPickerData.count
            }else{
                return petPhysicalActivityPickerData.count
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            //return petGenrePickerData[row]
            if pickerView.tag == 1{
                return petGenrePickerData[row]
            }else if pickerView.tag == 2{
                return petAgePickerData[row]
            }else if pickerView.tag == 3 {
                return petSizePickerData[row]
            }else if pickerView.tag == 4 {
                return petWeightPickerData[row]
            }else if pickerView.tag == 5 {
                return petSpecialDietPickerData[row]
            }else if pickerView.tag == 6 {
                return petPregnantPickerData[row]
            }else if pickerView.tag == 7 {
                return petBreastfeedingPickerData[row]
            }else{
                return petPhysicalActivityPickerData[row]
            }
        }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        let petGenreValueSelected = petGenrePickerData[row] as String
        //        print(petGenreValueSelected)
        if pickerView.tag == 1{
            optionsPetGenre(row: row)
        }else if pickerView.tag == 2{
            let petAgeValueSelected = petAgePickerData[row] as String
            petAgeTextField.text = petAgeValueSelected
            print(petAgeValueSelected)
            
            petaAgeIndex = String(row + 4)
            print(petaAgeIndex)
        }else if pickerView.tag == 3 {
            let petSizeValueSelected = petSizePickerData[row] as String
            petSizeTextField.text = petSizeValueSelected
            print(petSizeValueSelected)
            
            petSizeIndex = String(row + 1)
            print(petSizeIndex)
        }else if pickerView.tag == 4 {
            let petWeightValueSelected = petWeightPickerData[row] as String
            petWeightTextField.text = petWeightValueSelected
            print(petWeightValueSelected)
            
            petWeightIndex = String(row + 4)
            print(petWeightIndex)
        }else if pickerView.tag == 5 {
            let petSpecialDietValueSelected = petSpecialDietPickerData[row] as String
            petSpecialDietTextField.text = petSpecialDietValueSelected
            print(petSpecialDietValueSelected)
            
        }else if pickerView.tag == 6 {
            let petPregnantValueSelected = petPregnantPickerData[row] as String
            petPregnantTextField.text = petPregnantValueSelected
            print(petPregnantValueSelected)
        }else if pickerView.tag == 7 {
            let petBreastFeedingValueSelected = petBreastfeedingPickerData[row] as String
            petBreastFeedingTextField.text = petBreastFeedingValueSelected
            print(petBreastFeedingValueSelected)
        }else{
            let petPhysicalActivityValueSelected = petPhysicalActivityPickerData[row] as String
            petPhysicalActivityTextField.text = petPhysicalActivityValueSelected
            print(petPhysicalActivityValueSelected)
            
            petPhysicalActivityIndex = String(row + 1)
            print(petPhysicalActivityIndex)
        }
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.autoresizingMask = .flexibleHeight
        
        //let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(self.action))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Hecho", style: .plain, target: self, action: #selector(self.action))
        
        toolBar.backgroundColor = UIColor.yellow
        toolBar.tintColor = UIColor.brown
        
        var frame = toolBar.frame
        frame.size.height = 44.0
        toolBar.frame = frame
        //toolBar.setItems([cancelButton, flexSpace, doneButton], animated: true)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        petGenreTextField.inputAccessoryView = toolBar
        petAgeTextField.inputAccessoryView = toolBar
        petSizeTextField.inputAccessoryView = toolBar
        petWeightTextField.inputAccessoryView = toolBar
        petSpecialDietTextField.inputAccessoryView = toolBar
        petPregnantTextField.inputAccessoryView = toolBar
        petBreastFeedingTextField.inputAccessoryView = toolBar
        petPhysicalActivityTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
          view.endEditing(true)
    }

    func displayAlertSaved() {
        let alert = UIAlertController(title: "Configuración Guardada", message: "La configuración se ha guardado exitosamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"Aceptar\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlertEmptyField() {
        let alert = UIAlertController(title: "Campos Vacíos", message: "Todos los campos son requeridos.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"Aceptar\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        
        if petOwnerTextField.text == "" || petNameTextField.text == "" || petGenreTextField.text == "" || petBreedTextField.text == "" || petAgeTextField.text == "" || petSizeTextField.text == "" || petPhysicalActivityTextField.text == "" || petSpecialDietTextField.text == "" || petWeightTextField.text == "" {
            
            displayAlertEmptyField()
            
        }else {
            
            registerPetProfileRest(token: usuario, nombreDuenio_per: petOwnerTextField.text!, nombreMascota_per: petNameTextField.text!, raza_per: petBreedTextField.text!, edad_per: petaAgeIndex, genero_per: petGenreIndex, tamanio_per: petSizeIndex, actFisica_per: petPhysicalActivityIndex, dieta_per: petSpecialDietTextField.text!, peso_per: petWeightIndex, prenia_per: petPregnantTextField.text!, lactancia_per: petBreastFeedingTextField.text!)
            
            displayAlertSaved()
            
        }
    }
    
    func registerPetProfileRest(token: String, nombreDuenio_per: String, nombreMascota_per: String, raza_per: String, edad_per: String, genero_per: String, tamanio_per: String, actFisica_per: String, dieta_per: String, peso_per: String, prenia_per: String, lactancia_per: String) {
        
        let url = "http://n-systems-mx.com/tta069/controlador/guardarPerro.php"
        let parameters = ["token"      : token,
                   "nombreDuenio_per"  : nombreDuenio_per,
                   "nombreMascota_per" : nombreMascota_per,
                   "raza_per"          : raza_per,
                   "edad_per"          : edad_per,
                   "genero_per"        : genero_per,
                   "tamanio_per"       : tamanio_per,
                   "actFisica_per"     : actFisica_per,
                   "dieta_per"         : dieta_per,
                   "peso_per"          : peso_per,
                   "prenia_per"        : prenia_per,
                   "lactancia_per"     : lactancia_per
               ]

        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            print(response.result)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "MenuPrincipalButtonToMenuPrincipal" {
            guard let menuPrincipalBVC = segue.destination as? MenuPrincipalViewController else {
                return
            }
            menuPrincipalBVC.usuario = self.usuario
        }
    }
    
}
