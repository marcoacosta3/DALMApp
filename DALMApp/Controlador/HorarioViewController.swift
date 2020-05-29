//
//  HorarioViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class HorarioViewController: UIViewController {
    
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
