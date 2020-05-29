//
//  GatoViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class GatoViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
