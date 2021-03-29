//
//  EditarPerfilViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire

//Define la clase y los protocolos de textfield y picker
class EditarPerfilViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Outlets de los textfield, picker, label, botones
    @IBOutlet weak var petOwnerTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petBreedTextField: UITextField!
    @IBOutlet weak var petKindPicker: UIPickerView!
    @IBOutlet weak var petKindTextField: UITextField!
    @IBOutlet weak var petGenrePicker: UIPickerView!
    @IBOutlet weak var petGenreTextField: UITextField!
    @IBOutlet weak var dogSizePicker: UIPickerView!
    @IBOutlet weak var dogSizeTextField: UITextField!
    @IBOutlet weak var dogAgePicker: UIPickerView!
    @IBOutlet weak var dogAgeTextField: UITextField!
    @IBOutlet weak var catAgePicker: UIPickerView!
    @IBOutlet weak var catAgeTextField: UITextField!
    @IBOutlet weak var dogWeightPicker: UIPickerView!
    @IBOutlet weak var dogWeightTextField: UITextField!
    @IBOutlet weak var catWeightPicker: UIPickerView!
    @IBOutlet weak var catWeightTextField: UITextField!
    @IBOutlet weak var petPhysicalActivityPicker: UIPickerView!
    @IBOutlet weak var petPhysicalActivityTextField: UITextField!
    @IBOutlet weak var petSpecialDietPicker: UIPickerView!
    @IBOutlet weak var petSpecialDietTextField: UITextField!
    @IBOutlet weak var petBreastFeedingPicker: UIPickerView!
    @IBOutlet weak var petBreastFeedingTextField: UITextField!
    @IBOutlet weak var petPregnantPicker: UIPickerView!
    @IBOutlet weak var petPregnantTextField: UITextField!
    @IBOutlet weak var petBreastFeedingLabel: UILabel!
    @IBOutlet weak var petPregnantLabel: UILabel!
    @IBOutlet weak var petPhysicalActivityLabel: UILabel!
    @IBOutlet weak var petSpecialDietLabel: UILabel!
    @IBOutlet weak var changeAudioButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    //Variables para los datos de los pickers
    var petKindPickerData: [String] = [String]( )
    var petGenrePickerData: [String] = [String]( )
    var dogSizePickerData: [String] = [String]( )
    var dogAgePickerData: [String] = [String]( )
    var catAgePickerData: [String] = [String]( )
    var dogWeightPickerData: [String] = [String]( )
    var catWeightPickerData: [String] = [String]( )
    var petPhysicalActivityPickerData: [String] = [String]( )
    var petSpecialDietPickerData: [String] = [String]( )
    var petPregnantPickerData: [String] = [String]( )
    var petBreastfeedingPickerData: [String] = [String]( )
    
    //Variables usuario para token y de índices
    var usuario: String = ""
    //var perfilMascota: PerfilMascota!
    var petKindIndex: String = ""
    var petGenreIndex: String = ""
    var dogSizeIndex: String = ""
    var dogAgeIndex: String = ""
    var dogWeightIndex: String = ""
    var catAgeIndex: String = ""
    var catWeightIndex: String = ""
    var petPhysicalActivityIndex: String = ""
    var petKindSelector: String = ""
    
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
        
        //Asignación de los delegados de textfield, picker
        petOwnerTextField.delegate = self
        petNameTextField.delegate = self
        petBreedTextField.delegate = self
        self.petKindPicker.delegate = self
        self.petKindPicker.dataSource = self
        self.petGenrePicker.delegate = self
        self.petGenrePicker.dataSource = self
        self.dogSizePicker.delegate = self
        self.dogSizePicker.dataSource = self
        self.dogAgePicker.delegate = self
        self.dogAgePicker.dataSource = self
        self.catAgePicker.delegate = self
        self.catAgePicker.dataSource = self
        self.dogWeightPicker.delegate = self
        self.dogWeightPicker.dataSource = self
        self.catWeightPicker.delegate = self
        self.catWeightPicker.dataSource = self
        self.petPhysicalActivityPicker.delegate = self
        self.petPhysicalActivityPicker.dataSource = self
        self.petSpecialDietPicker.delegate = self
        self.petSpecialDietPicker.dataSource = self
        self.petPregnantPicker.delegate = self
        self.petPregnantPicker.dataSource = self
        self.petBreastFeedingPicker.delegate = self
        self.petBreastFeedingPicker.dataSource = self
        
        //Pone los pickers en los textfield
        petKindTextField.inputView = petKindPicker
        petKindPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petGenreTextField.inputView = petGenrePicker
        petGenrePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dogSizeTextField.inputView = dogSizePicker
        dogSizePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dogAgeTextField.inputView = dogAgePicker
        dogAgePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        catAgeTextField.inputView = catAgePicker
        catAgePicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dogWeightTextField.inputView = dogWeightPicker
        dogWeightPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        catWeightTextField.inputView = catWeightPicker
        catWeightPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petPhysicalActivityTextField.inputView = petPhysicalActivityPicker
        petPhysicalActivityPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petSpecialDietTextField.inputView = petSpecialDietPicker
        petSpecialDietPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petPregnantTextField.inputView = petPregnantPicker
        petPregnantPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        petBreastFeedingTextField.inputView = petBreastFeedingPicker
        petBreastFeedingPicker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //Datos de las opciones que llevará cada picker
        petKindPickerData = ["Perro", "Gato"]
        petGenrePickerData = ["Macho", "Hembra"]
        dogSizePickerData = ["Mini", "Pequeño", "Mediano", "Grande", "Gigante"]
        dogAgePickerData = ["Cachorro hasta 10 semanas", "Cachorro de 10 semanas a 6 meses", "Cachorro de 6 hasta 12 meses", "Adulto (De 1 a 5 años)", "Vejez (Mayor a 5 años)"]
        catAgePickerData = ["Minino", "Adulto", "Vejez"]
        dogWeightPickerData = ["Menor de 3.5kg", "Entre 3.5-7.5kg", "Entre 7.5-11.5kg", "Entre 11.5-15.5kg", "Entre 15.5-19.5kg", "Entre 19.5-23.5kg", "Entre 23.5-27.5kg", "Entre 27.5-33.5kg", "Entre 33.5-39kg", "Entre 39.5-45.5Kg", "Entre 45.5-50Kg"]
        catWeightPickerData = ["De 1 a 2kg", "De 3 a 5kg", "Más de 5kg"]
        petPhysicalActivityPickerData = ["Baja", "Normal", "Alta"]
        petSpecialDietPickerData = ["Si", "No"]
        petPregnantPickerData = ["Si", "No"]
        petBreastfeedingPickerData = ["Si", "No"]
        
        //Deshabilita los picker
        petGenrePicker.isUserInteractionEnabled = false
        dogSizePicker.isUserInteractionEnabled = false
        dogAgePicker.isUserInteractionEnabled = false
        catAgePicker.isUserInteractionEnabled = false
        dogWeightPicker.isUserInteractionEnabled = false
        catWeightPicker.isUserInteractionEnabled = false
        petPhysicalActivityPicker.isUserInteractionEnabled = false
        petSpecialDietPicker.isUserInteractionEnabled = false
        petPregnantPicker.isUserInteractionEnabled = false
        petBreastFeedingPicker.isUserInteractionEnabled = false
        
        //Deshabilita los textfield
        petGenreTextField.isUserInteractionEnabled = false
        dogSizeTextField.isUserInteractionEnabled = false
        dogAgeTextField.isUserInteractionEnabled = false
        catAgeTextField.isUserInteractionEnabled = false
        dogWeightTextField.isUserInteractionEnabled = false
        catWeightTextField.isUserInteractionEnabled = false
        petPhysicalActivityTextField.isUserInteractionEnabled = false
        petSpecialDietTextField.isUserInteractionEnabled = false
        petPregnantTextField.isUserInteractionEnabled = false
        petBreastFeedingTextField.isUserInteractionEnabled = false
        
        //Transparencia de picker, textfield y label
        petGenrePicker.alpha = 0.01
        dogSizePicker.alpha = 0.01
        dogAgePicker.alpha = 0.01
        catAgePicker.alpha = 0.01
        dogWeightPicker.alpha = 0.01
        catWeightPicker.alpha = 0.01
        petPhysicalActivityPicker.alpha = 0.01
        petSpecialDietPicker.alpha = 0.01
        petPregnantPicker.alpha = 0.01
        petBreastFeedingPicker.alpha = 0.01
        petGenreTextField.alpha = 0.5
        dogSizeTextField.alpha = 0.5
        dogAgeTextField.alpha = 0.5
        catAgeTextField.alpha = 0.5
        dogWeightTextField.alpha = 0.5
        catWeightTextField.alpha = 0.5
        petPhysicalActivityTextField.alpha = 0.5
        petSpecialDietTextField.alpha = 0.5
        petPregnantTextField.alpha = 0.5
        petBreastFeedingTextField.alpha = 0.5
        petPhysicalActivityLabel.alpha = 0.5
        petSpecialDietLabel.alpha = 0.5
        petPregnantLabel.alpha = 0.5
        petBreastFeedingLabel.alpha = 0.5
        
        dismissPickerView()
        
        //Diseño de botones
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 3
        mainMenuButton.layer.cornerRadius = mainMenuButton.frame.size.height / 3
        changeAudioButton.layer.cornerRadius = changeAudioButton.frame.size.height / 3
        print(usuario + " Editar")
        petProfileRest(usuario: usuario)
    }
    
    //Método del número de componentes del picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Método para saber cuantos elementos hay en cada picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return petKindPickerData.count
        }else if pickerView.tag == 2{
            return petGenrePickerData.count
        }else if pickerView.tag == 3{
            return dogSizePickerData.count
        }else if pickerView.tag == 4 {
            return dogAgePickerData.count
        }else if pickerView.tag == 5 {
            return catAgePickerData.count
        }else if pickerView.tag == 6 {
            return dogWeightPickerData.count
        }else if pickerView.tag == 7 {
            return catWeightPickerData.count
        }else if pickerView.tag == 8 {
            return petPhysicalActivityPickerData.count
        }else if pickerView.tag == 9 {
            return petSpecialDietPickerData.count
        }else if pickerView.tag == 10 {
            return petPregnantPickerData.count
        }else{
            return petBreastfeedingPickerData.count
        }
    }
    
    //Método para poner las opciones de cada picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return petKindPickerData[row]
        }else if pickerView.tag == 2{
            return petGenrePickerData[row]
        }else if pickerView.tag == 3{
            return dogSizePickerData[row]
        }else if pickerView.tag == 4 {
            return dogAgePickerData[row]
        }else if pickerView.tag == 5 {
            return catAgePickerData[row]
        }else if pickerView.tag == 6 {
            return dogWeightPickerData[row]
        }else if pickerView.tag == 7 {
            return catWeightPickerData[row]
        }else if pickerView.tag == 8 {
            return petPhysicalActivityPickerData[row]
        }else if pickerView.tag == 9 {
            return petSpecialDietPickerData[row]
        }else if pickerView.tag == 10 {
            return petPregnantPickerData[row]
        }else{
            return petBreastfeedingPickerData[row]
        }
    }
    
    //Método para poner en el textfield la opción seleccionada del picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            optionsPetKind(row: row)
        }else if pickerView.tag == 2{
            optionsPetGenre(row: row)
        }else if pickerView.tag == 3{
            let dogSizeValueSelected = dogSizePickerData[row] as String
            dogSizeTextField.text = dogSizeValueSelected
            print(dogSizeValueSelected)
            
            dogSizeIndex = String(row + 1)
            print(dogSizeIndex)
        }else if pickerView.tag == 4 {
            let dogAgeValueSelected = dogAgePickerData[row] as String
            dogAgeTextField.text = dogAgeValueSelected
            print(dogAgeValueSelected)
            
            dogAgeIndex = String(row + 4)
            print(dogAgeIndex)
        }else if pickerView.tag == 5 {
            let catAgeValueSelected = catAgePickerData[row] as String
            catAgeTextField.text = catAgeValueSelected
            print(catAgeValueSelected)
            
            catAgeIndex = String(row + 1)
            print(catAgeIndex)
        }else if pickerView.tag == 6 {
            let dogWeightValueSelected = dogWeightPickerData[row] as String
            dogWeightTextField.text = dogWeightValueSelected
            print(dogWeightValueSelected)
            
            dogWeightIndex = String(row + 4)
            print(dogWeightIndex)
        }else if pickerView.tag == 7 {
            let catWeightValueSelected = catWeightPickerData[row] as String
            catWeightTextField.text = catWeightValueSelected
            print(catWeightValueSelected)
            
            catWeightIndex = String(row + 1)
            print(catWeightIndex)
        }else if pickerView.tag == 8 {
            let petPhysicalActivityValueSelected = petPhysicalActivityPickerData[row] as String
            petPhysicalActivityTextField.text = petPhysicalActivityValueSelected
            print(petPhysicalActivityValueSelected)
            
            petPhysicalActivityIndex = String(row + 1)
            print(petPhysicalActivityIndex)
        }else if pickerView.tag == 9 {
            let petSpecialDietValueSelected = petSpecialDietPickerData[row] as String
            petSpecialDietTextField.text = petSpecialDietValueSelected
            print(petSpecialDietValueSelected)
        }else if pickerView.tag == 10 {
            let petPregnantValueSelected = petPregnantPickerData[row] as String
            petPregnantTextField.text = petPregnantValueSelected
            print(petPregnantValueSelected)
        }else{
            let petBreastFeedingValueSelected = petBreastfeedingPickerData[row] as String
            petBreastFeedingTextField.text = petBreastFeedingValueSelected
            print(petBreastFeedingValueSelected)
        }
        
    }
    
    //Método para saber cuando termina de escribir en textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        print(textField.text!)
        
        return true
    }
    
    //Método para habilitar o deshabilitar opciones de cada tipo de mascota
    func optionsPetKind(row: Int) {
        //        if petKindPickerData[row] == "--"{
        //            let petKindValueSelected = petKindPickerData[row] as String
        //
        //            petGenrePicker.isUserInteractionEnabled = false
        //            dogSizePicker.isUserInteractionEnabled = false
        //            dogAgePicker.isUserInteractionEnabled = false
        //            catAgePicker.isUserInteractionEnabled = false
        //            dogWeightPicker.isUserInteractionEnabled = false
        //            catWeightPicker.isUserInteractionEnabled = false
        //            petPhysicalActivityPicker.isUserInteractionEnabled = false
        //            petSpecialDietPicker.isUserInteractionEnabled = false
        //            petPregnantPicker.isUserInteractionEnabled = false
        //            petBreastFeedingPicker.isUserInteractionEnabled = false
        //
        //            petGenreTextField.isUserInteractionEnabled = false
        //            dogSizeTextField.isUserInteractionEnabled = false
        //            dogAgeTextField.isUserInteractionEnabled = false
        //            catAgeTextField.isUserInteractionEnabled = false
        //            dogWeightTextField.isUserInteractionEnabled = false
        //            catWeightTextField.isUserInteractionEnabled = false
        //            petPhysicalActivityTextField.isUserInteractionEnabled = false
        //            petSpecialDietTextField.isUserInteractionEnabled = false
        //            petPregnantTextField.isUserInteractionEnabled = false
        //            petBreastFeedingTextField.isUserInteractionEnabled = false
        //
        //            petGenrePicker.alpha = 0.01
        //            dogSizePicker.alpha = 0.01
        //            dogAgePicker.alpha = 0.01
        //            catAgePicker.alpha = 0.01
        //            dogWeightPicker.alpha = 0.01
        //            catWeightPicker.alpha = 0.01
        //            petPhysicalActivityPicker.alpha = 0.01
        //            petSpecialDietPicker.alpha = 0.01
        //            petPregnantPicker.alpha = 0.01
        //            petBreastFeedingPicker.alpha = 0.01
        //            petGenreTextField.alpha = 0.5
        //            dogSizeTextField.alpha = 0.5
        //            dogAgeTextField.alpha = 0.5
        //            catAgeTextField.alpha = 0.5
        //            dogWeightTextField.alpha = 0.5
        //            catWeightTextField.alpha = 0.5
        //            petPhysicalActivityTextField.alpha = 0.5
        //            petSpecialDietTextField.alpha = 0.5
        //            petPregnantTextField.alpha = 0.5
        //            petBreastFeedingTextField.alpha = 0.5
        //
        //
        //            petKindTextField.text = petKindValueSelected
        //            petGenreTextField.text = ""
        //            dogSizeTextField.text = ""
        //            dogAgeTextField.text = ""
        //            catAgeTextField.text = ""
        //            dogWeightTextField.text = ""
        //            catWeightTextField.text = ""
        //            petPhysicalActivityTextField.text = ""
        //            petSpecialDietTextField.text = ""
        //            petPregnantTextField.text = ""
        //            petBreastFeedingTextField.text = ""
        //
        //            print(petKindValueSelected)
        //        }else
        //Si es tipo perro deahabilita las opciones de gato
        if petKindPickerData[row] == "Perro"{
            let petKindValueSelected = petKindPickerData[row] as String
            
            petGenrePicker.isUserInteractionEnabled = true
            dogSizePicker.isUserInteractionEnabled = true
            dogAgePicker.isUserInteractionEnabled = true
            catAgePicker.isUserInteractionEnabled = false
            dogWeightPicker.isUserInteractionEnabled = true
            catWeightPicker.isUserInteractionEnabled = false
            petPhysicalActivityPicker.isUserInteractionEnabled = true
            petSpecialDietPicker.isUserInteractionEnabled = true
            petPregnantPicker.isUserInteractionEnabled = false
            petBreastFeedingPicker.isUserInteractionEnabled = false
            
            petGenreTextField.isUserInteractionEnabled = true
            dogSizeTextField.isUserInteractionEnabled = true
            dogAgeTextField.isUserInteractionEnabled = true
            catAgeTextField.isUserInteractionEnabled = false
            dogWeightTextField.isUserInteractionEnabled = true
            catWeightTextField.isUserInteractionEnabled = false
            petPhysicalActivityTextField.isUserInteractionEnabled = true
            petSpecialDietTextField.isUserInteractionEnabled = true
            petPregnantTextField.isUserInteractionEnabled = false
            petBreastFeedingTextField.isUserInteractionEnabled = false
            
            
            petGenrePicker.alpha = 1
            dogSizePicker.alpha = 1
            dogAgePicker.alpha = 1
            catAgePicker.alpha = 0.01
            dogWeightPicker.alpha = 1
            catWeightPicker.alpha = 0.01
            petPhysicalActivityPicker.alpha = 1
            petSpecialDietPicker.alpha = 1
            petPregnantPicker.alpha = 0.01
            petBreastFeedingPicker.alpha = 0.01
            petGenreTextField.alpha = 1
            dogSizeTextField.alpha = 1
            dogAgeTextField.alpha = 1
            catAgeTextField.alpha = 0.5
            dogWeightTextField.alpha = 1
            catWeightTextField.alpha = 0.5
            petPhysicalActivityTextField.alpha = 1
            petSpecialDietTextField.alpha = 1
            petPregnantTextField.alpha = 0.5
            petBreastFeedingTextField.alpha = 0.5
            petPhysicalActivityLabel.alpha = 1
            petSpecialDietLabel.alpha = 1
            petPregnantLabel.alpha = 0.5
            petBreastFeedingLabel.alpha = 0.5
            
            petKindTextField.text = petKindValueSelected
            petGenreTextField.text = ""
            //catSizeTextField.text = ""
            catAgeTextField.text = ""
            catWeightTextField.text = ""
            petPhysicalActivityTextField.text = ""
            petSpecialDietTextField.text = ""
            petPregnantTextField.text = ""
            petBreastFeedingTextField.text = ""
            
            print(petKindValueSelected)
            petKindIndex = String(row + 1)
            print(petKindIndex)
            
        }else{
            //Si es tipo gato deahabilita las opciones de perro
            let petKindValueSelected = petKindPickerData[row] as String
            
            petGenrePicker.isUserInteractionEnabled = true
            dogSizePicker.isUserInteractionEnabled = false
            dogAgePicker.isUserInteractionEnabled = false
            catAgePicker.isUserInteractionEnabled = true
            dogWeightPicker.isUserInteractionEnabled = false
            catWeightPicker.isUserInteractionEnabled = true
            petPhysicalActivityPicker.isUserInteractionEnabled = true
            petSpecialDietPicker.isUserInteractionEnabled = true
            petPregnantPicker.isUserInteractionEnabled = false
            petBreastFeedingPicker.isUserInteractionEnabled = false
            
            petGenreTextField.isUserInteractionEnabled = true
            dogSizeTextField.isUserInteractionEnabled = false
            dogAgeTextField.isUserInteractionEnabled = false
            catAgeTextField.isUserInteractionEnabled = true
            dogWeightTextField.isUserInteractionEnabled = false
            catWeightTextField.isUserInteractionEnabled = true
            petPhysicalActivityTextField.isUserInteractionEnabled = true
            petSpecialDietTextField.isUserInteractionEnabled = true
            petPregnantTextField.isUserInteractionEnabled = false
            petBreastFeedingTextField.isUserInteractionEnabled = false
            
            
            petGenrePicker.alpha = 1
            dogSizePicker.alpha = 0.01
            dogAgePicker.alpha = 0.01
            catAgePicker.alpha = 1
            dogWeightPicker.alpha = 0.01
            catWeightPicker.alpha = 1
            petPhysicalActivityPicker.alpha = 1
            petSpecialDietPicker.alpha = 1
            petPregnantPicker.alpha = 0.01
            petBreastFeedingPicker.alpha = 0.01
            petGenreTextField.alpha = 1
            dogSizeTextField.alpha = 0.5
            dogAgeTextField.alpha = 0.5
            catAgeTextField.alpha = 1
            dogWeightTextField.alpha = 0.5
            catWeightTextField.alpha = 1
            petPhysicalActivityTextField.alpha = 1
            petSpecialDietTextField.alpha = 1
            petPhysicalActivityLabel.alpha = 1
            petPregnantTextField.alpha = 0.5
            petBreastFeedingTextField.alpha = 0.5
            petSpecialDietLabel.alpha = 1
            petPregnantLabel.alpha = 0.5
            petBreastFeedingLabel.alpha = 0.5
            
            petKindTextField.text = petKindValueSelected
            petGenreTextField.text = ""
            dogSizeTextField.text = ""
            dogAgeTextField.text = ""
            dogWeightTextField.text = ""
            petPhysicalActivityTextField.text = ""
            petSpecialDietTextField.text = ""
            petPregnantTextField.text = ""
            petBreastFeedingTextField.text = ""
            
            print(petKindValueSelected)
            
            print(petKindValueSelected)
            petKindIndex = String(row + 1)
        }
    }
    
    //Método para habilitar o deshabilitar opciones de género hembra
    func optionsPetGenre(row:Int) {
        //Si es género hembra habilita sus opciones
        if petGenrePickerData[row] == "Hembra"{
            let petGenreValueSelected = petGenrePickerData[row] as String
            petBreastFeedingPicker.isUserInteractionEnabled = true
            petPregnantPicker.isUserInteractionEnabled = true
            petPregnantTextField.isUserInteractionEnabled = true
            petBreastFeedingTextField.isUserInteractionEnabled = true
            
            petPregnantPicker.alpha = 1
            petBreastFeedingPicker.alpha = 1
            petPregnantTextField.alpha = 1
            petBreastFeedingTextField.alpha = 1
            petPregnantLabel.alpha = 1
            petBreastFeedingLabel.alpha = 1
            
            petGenreTextField.text = petGenreValueSelected
            print(row)
            petGenreIndex = String(row + 1)
            print(petGenreIndex)
            print(petGenreValueSelected)
        }else{
            //Si es género macho deahabilita las opciones de hembra
            let petGenreValueSelected = petGenrePickerData[row] as String
            petBreastFeedingPicker.isUserInteractionEnabled = false
            petPregnantPicker.isUserInteractionEnabled = false
            petPregnantTextField.isUserInteractionEnabled = false
            petBreastFeedingTextField.isUserInteractionEnabled = false
            
            petPregnantPicker.alpha = 0.01
            petBreastFeedingPicker.alpha = 0.01
            petPregnantTextField.alpha = 0.5
            petBreastFeedingTextField.alpha = 0.5
            petPregnantLabel.alpha = 0.5
            petBreastFeedingLabel.alpha = 0.5
            
            petGenreTextField.text = petGenreValueSelected
            petPregnantTextField.text = ""
            petBreastFeedingTextField.text = ""
            
            print(petGenreValueSelected)
            
            petGenreIndex = String(row + 1)
            print(petGenreIndex)
        }
    }
    
    //Método para descartar picker
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.autoresizingMask = .flexibleHeight
        
        //        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(self.action))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Hecho", style: .plain, target: self, action: #selector(self.action))
        
        toolBar.backgroundColor = UIColor.yellow
        toolBar.tintColor = UIColor.brown
        
        var frame = toolBar.frame
        frame.size.height = 44.0
        toolBar.frame = frame
        toolBar.setItems([flexSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        petKindTextField.inputAccessoryView = toolBar
        petGenreTextField.inputAccessoryView = toolBar
        dogSizeTextField.inputAccessoryView = toolBar
        dogAgeTextField.inputAccessoryView = toolBar
        catAgeTextField.inputAccessoryView = toolBar
        dogWeightTextField.inputAccessoryView = toolBar
        catWeightTextField.inputAccessoryView = toolBar
        petPhysicalActivityTextField.inputAccessoryView = toolBar
        petSpecialDietTextField.inputAccessoryView = toolBar
        petPregnantTextField.inputAccessoryView = toolBar
        petBreastFeedingTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func action() {
        view.endEditing(true)
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
    
    //Action de botón para guardar el perfil de mascota
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        //Llamado al método de editar perfil gato y muestra mensaje
        if dogAgeTextField.text?.isEmpty ?? false {
            catProfileEditRest(token: usuario, nombre_duenio: petOwnerTextField.text!, nombreMascota_gat: petNameTextField.text!, raza: petBreedTextField.text!, genero_gat: petGenreIndex, edad_gat: catAgeIndex, peso_gat: catWeightIndex, actFisica_gat: petPhysicalActivityIndex, dieta_gat: petSpecialDietTextField.text!, prenia_gat: petPregnantTextField.text!, lactancia_gat: petBreastFeedingTextField.text!)
            displayAlertSaved()
        }else {
            //Llamado al método de editar perfil perro y muestra mensaje
            dogProfileEditRest(token: usuario, nombre_duenio: petOwnerTextField.text!, nombreMascota_per: petNameTextField.text!, raza_per: petBreedTextField.text!, edad_per: dogAgeIndex, genero_per: petGenreIndex, tamanio_per: dogSizeIndex, actFisica_per: petPhysicalActivityIndex, dieta_per: petSpecialDietTextField.text!, peso_per: dogWeightIndex, prenia_per: petPregnantTextField.text!, lactancia_per: petBreedTextField.text!)
            displayAlertSaved()
        }
    }
    
    //Método para obtener los datos del perfil de la mascota
    func petProfileRest(usuario: String) {
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/modificarPerfil.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo PerfilMascota
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: PerfilMascota.self) { (response) in
            print(response.result)
            
            //Llena los textfield con la información de los datos obtenidos
            self.petOwnerTextField.text = response.value?.nombre_duenio
            self.petNameTextField.text = response.value?.nombre_mascota
            self.petBreedTextField.text = response.value?.raza
            //self.optionsPetKind(row: Int(response.value.tipo))
            //self.petKindTextField.text = "Espera de resultado"
            let petKindData = response.value?.tipo ?? ""
            self.optionsPetKind(row: (Int(petKindData) ?? 0) - 1)
            self.petKindSelector = petKindData
            
            //Si es tipo perro, llena sus campos
            if (Int(petKindData) ?? 0) == 1 {
                //self.petGenreTextField.text = response.value?.genero
                let petGenreData = response.value?.genero ?? ""
                self.optionsPetGenre(row: (Int(petGenreData) ?? 0) - 1)
                //self.dogAgeTextField.text = response.value?.edad
                let dogAgeString = response.value?.edad ?? ""
                let dogAgeData = self.dogAgePickerData[(Int(dogAgeString) ?? 0) - 4] as String
                self.dogAgeTextField.text = dogAgeData
                //self.dogWeightTextField.text = response.value?.peso
                let dogWeightString = response.value?.peso ?? ""
                let dogWeightData = self.dogWeightPickerData[(Int(dogWeightString) ?? 0) - 4] as String
                self.dogWeightTextField.text = dogWeightData
                //self.dogSizeTextField.text = response.value?.tamanio
                let dogSizeString = response.value?.tamanio ?? ""
                let dogSizeData = self.dogSizePickerData[(Int(dogSizeString) ?? 0) - 1] as String
                self.dogSizeTextField.text = dogSizeData
                let petPhysicalActivityString = response.value?.actividad_fisica ?? ""
                let petPhysicalActivityData = self.petPhysicalActivityPickerData[(Int(petPhysicalActivityString) ?? 0) - 1] as String
                self.petPhysicalActivityTextField.text = petPhysicalActivityData
                self.petSpecialDietTextField.text = response.value?.dieta
                self.petPregnantTextField.text = response.value?.prenia
                self.petBreastFeedingTextField.text = response.value?.lactancia
            }else {
                //Si es gato llena sus campos
                //self.petGenreTextField.text = response.value?.genero
                let petGenreData = response.value?.genero ?? ""
                self.optionsPetGenre(row: (Int(petGenreData) ?? 0) - 1)
                let catAgeString = response.value?.edad ?? ""
                let catAgeData = self.catAgePickerData[(Int(catAgeString) ?? 0) - 1] as String
                self.catAgeTextField.text = catAgeData
                //self.catWeightTextField.text = response.value?.peso
                let catWeightString = response.value?.peso ?? ""
                let catWeightData = self.catWeightPickerData[(Int(catWeightString) ?? 0) - 1] as String
                self.catWeightTextField.text = catWeightData
                //self.petPhysicalActivityTextField.text = response.value?.actividad_fisica
                let petPhysicalActivityString = response.value?.actividad_fisica ?? ""
                let petPhysicalActivityData = self.petPhysicalActivityPickerData[(Int(petPhysicalActivityString) ?? 0) - 1] as String
                self.petPhysicalActivityTextField.text = petPhysicalActivityData
                self.petSpecialDietTextField.text = response.value?.dieta
                self.petPregnantTextField.text = response.value?.prenia
                self.petBreastFeedingTextField.text = response.value?.lactancia
            }
            
        }
    }
    
    //Método para guardar el perfil de la mascota perro actualizado
    func dogProfileEditRest(token: String, nombre_duenio: String, nombreMascota_per: String, raza_per: String, edad_per: String, genero_per: String, tamanio_per: String, actFisica_per: String, dieta_per: String, peso_per: String, prenia_per: String, lactancia_per: String){
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/guardarPerro.php"
        //Parámetros de la petición al webservice
        let parameters = ["token"     : token,
                          "nombre_duenio"     : nombre_duenio,
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
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            print(response.result)
        }
    }
    
    //Método para guardar el perfil de la mascota gato actualizado
    func catProfileEditRest(token: String, nombre_duenio: String, nombreMascota_gat: String, raza: String, genero_gat: String, edad_gat: String, peso_gat: String, actFisica_gat: String, dieta_gat: String, prenia_gat: String, lactancia_gat: String) {
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/guardarGato.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": token,
                          "Nombre_duenio"     :nombre_duenio,
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
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            print(response.result)
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
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalButtonToAudio" {
            guard let menuPrincipalBVC = segue.destination as? AudioViewController else {
                return
            }
            menuPrincipalBVC.usuario = self.usuario
        }
    }
    
}
