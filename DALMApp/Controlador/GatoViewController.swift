//
//  GatoViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire

class GatoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var petOwnerTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petBreedTextField: UITextField!
    @IBOutlet weak var petGenrePicker: UIPickerView!
    @IBOutlet weak var petGenreTextField: UITextField!
    @IBOutlet weak var petAgePicker: UIPickerView!
    @IBOutlet weak var petAgeTextField: UITextField!
    @IBOutlet weak var petSpecialDietPicker: UIPickerView!
    @IBOutlet weak var petSpecialDietTextField: UITextField!
    @IBOutlet weak var petPhysicalActivityPicker: UIPickerView!
    @IBOutlet weak var petPhysicalActivityTextField: UITextField!
    @IBOutlet weak var petWeightPicker: UIPickerView!
    @IBOutlet weak var petWeightTextField: UITextField!
    @IBOutlet weak var petPregnantPicker: UIPickerView!
    @IBOutlet weak var petPregnantTextField: UITextField!
    @IBOutlet weak var petBreastFeedingPicker: UIPickerView!
    @IBOutlet weak var petBreastFeedingTextField: UITextField!
    @IBOutlet weak var petPregnantLabel: UILabel!
    @IBOutlet weak var petBreastFeedingLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    var petGenrePickerData: [String] = [String]( )
    var petAgePickerData: [String] = [String]( )
    var petPhysicalActivityPickerData: [String] = [String]( )
    var petSpecialDietPickerData: [String] = [String]( )
    var petWeightPickerData: [String] = [String]( )
    var petPregnantPickerData: [String] = [String]( )
    var petBreastfeedingPickerData: [String] = [String]( )
    
    var usuario: String = ""
    var petGenreIndex: String = ""
    var petAgeIndex: String = ""
    var petWeightIndex: String = ""
    var petPhysicalActivityIndex: String = ""
    
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
        petBreedTextField.tag = 3
        self.petGenrePicker.delegate = self
        self.petGenrePicker.dataSource = self
        self.petAgePicker.delegate = self
        self.petAgePicker.dataSource = self
        self.petWeightPicker.delegate = self
        self.petWeightPicker.dataSource = self
        self.petPhysicalActivityPicker.delegate = self
        self.petPhysicalActivityPicker.dataSource = self
        self.petSpecialDietPicker.delegate = self
        self.petSpecialDietPicker.dataSource = self
        self.petPregnantPicker.delegate = self
        self.petPregnantPicker.dataSource = self
        self.petBreastFeedingPicker.delegate = self
        self.petBreastFeedingPicker.dataSource = self
        
        petGenreTextField.inputView = petGenrePicker
        petGenrePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petAgeTextField.inputView = petAgePicker
        petAgePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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
        
        petGenrePickerData = ["Macho", "Hembra"]
        petAgePickerData = ["Minino", "Adulto", "Vejez"]
        petWeightPickerData = ["De 1 a 2kg", "De 3 a 5kg", "Más de 5kg"]
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
        print(usuario + " Gato")
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return petGenrePickerData.count
        }else if pickerView.tag == 2{
            return petAgePickerData.count
        }else if pickerView.tag == 3 {
            return petWeightPickerData.count
        }else if pickerView.tag == 4 {
            return petPhysicalActivityPickerData.count
        }else if pickerView.tag == 5 {
            return petSpecialDietPickerData.count
        }else if pickerView.tag == 6 {
            return petPregnantPickerData.count
        }else{
            return petBreastfeedingPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return petGenrePickerData[row]
        }else if pickerView.tag == 2{
            return petAgePickerData[row]
        }else if pickerView.tag == 3 {
            return petWeightPickerData[row]
        }else if pickerView.tag == 4 {
            return petPhysicalActivityPickerData[row]
        }else if pickerView.tag == 5 {
            return petSpecialDietPickerData[row]
        }else if pickerView.tag == 6 {
            return petPregnantPickerData[row]
        }else {
            return petBreastfeedingPickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            optionsPetGenre(row: row)
        }else if pickerView.tag == 2{
            let petAgeValueSelected = petAgePickerData[row] as String
            petAgeTextField.text = petAgeValueSelected
            print(petAgeValueSelected)
            
            petAgeIndex = String(row + 1)
            print(petAgeIndex)
        }else if pickerView.tag == 3 {
            let petWeightValueSelected = petWeightPickerData[row] as String
            petWeightTextField.text = petWeightValueSelected
            print(petWeightValueSelected)
            
            petWeightIndex = String(row + 1)
            print(petWeightIndex)
        }else if pickerView.tag == 4 {
            let petPhysicalActivityValueSelected = petPhysicalActivityPickerData[row] as String
            petPhysicalActivityTextField.text = petPhysicalActivityValueSelected
            print(petPhysicalActivityValueSelected)
            
            petPhysicalActivityIndex = String(row + 1)
            print(petPhysicalActivityIndex)
        }else if pickerView.tag == 5 {
            let petSpecialDietValueSelected = petSpecialDietPickerData[row] as String
            petSpecialDietTextField.text = petSpecialDietValueSelected
            print(petSpecialDietValueSelected)
            
        }else if pickerView.tag == 6 {
            let petPregnantValueSelected = petPregnantPickerData[row] as String
            petPregnantTextField.text = petPregnantValueSelected
            print(petPregnantValueSelected)
        }else {
            let petBreastFeedingValueSelected = petBreastfeedingPickerData[row] as String
            petBreastFeedingTextField.text = petBreastFeedingValueSelected
            print(petBreastFeedingValueSelected)
        }
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
            
            petGenreIndex = String(row + 1)
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
            
            petGenreIndex = String(row + 1)
            print(petGenreIndex)
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
        toolBar.setItems([flexSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        petGenreTextField.inputAccessoryView = toolBar
        petAgeTextField.inputAccessoryView = toolBar
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
        if petOwnerTextField.text == "" || petNameTextField.text == "" || petBreedTextField.text == "" || petGenreTextField.text == "" || petAgeTextField.text == "" || petPhysicalActivityTextField.text == "" || petSpecialDietTextField.text == "" || petWeightTextField.text == "" {
            
            displayAlertEmptyField()
            
        }else {
            
            registerPetProfileRest(token: usuario, nombreDuenio_gat: petOwnerTextField.text!, nombreMascota_gat: petNameTextField.text!, raza: petBreedTextField.text!, genero_gat: petGenreIndex, edad_gat: petAgeIndex, peso_gat: petWeightIndex, actFisica_gat: petPhysicalActivityIndex, dieta_gat: petSpecialDietTextField.text!, prenia_gat: petPregnantTextField.text!, lactancia_gat: petBreastFeedingTextField.text!)
            
            displayAlertSaved()
            
        }
    }
    
    func registerPetProfileRest(token: String, nombreDuenio_gat: String, nombreMascota_gat: String, raza: String, genero_gat: String, edad_gat: String, peso_gat: String, actFisica_gat: String, dieta_gat: String, prenia_gat: String, lactancia_gat: String) {
        
        let url = "http://n-systems-mx.com/tta069/controlador/guardarGato.php"
        let parameters = ["token"      :token,
                   "nombreDuenio_gat"  :nombreDuenio_gat,
                   "nombreMascota_gat" :nombreMascota_gat,
                   "raza"              :raza,
                   "genero_gat"        :genero_gat,
                   "edad_gat"          :edad_gat,
                   "peso_gat"          :peso_gat,
                   "actFisica_gat"     :actFisica_gat,
                   "dieta_gat"         :dieta_gat,
                   "prenia_gat"        :prenia_gat,
                   "lactancia_gat"     :lactancia_gat
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
