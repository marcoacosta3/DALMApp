//
//  MenuPrincipalViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class MenuPrincipalViewController: UIViewController {
    
    @IBOutlet weak var registerPetProfileButton: UIButton!
    @IBOutlet weak var scheduleSettingsButton: UIButton!
    @IBOutlet weak var addAudioButton: UIButton!
    @IBOutlet weak var levelMonitoringButton: UIButton!
    @IBOutlet weak var dataSheetButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    
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
