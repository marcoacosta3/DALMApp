//
//  MonitoreoNivelViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire

class MonitoreoNivelViewController: UIViewController {
    
    @IBOutlet weak var foodLevel: UIButton!
    @IBOutlet weak var waterLevel: UIButton!
    
    var usuario: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodLevel.layer.cornerRadius = foodLevel.frame.size.height / 3
        waterLevel.layer.cornerRadius = waterLevel.frame.size.height / 3
        print(usuario + "Niveles")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "MonitoreoNivelToNivelAgua" {
            guard let nivelAguaVC = segue.destination as? NivelAguaViewController else {
                return
            }
            nivelAguaVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "MonitoreoNivelToNivelAlimento" {
            guard let nivelAlimentoVC = segue.destination as? NivelAlimentoViewController else {
                return
            }
            nivelAlimentoVC.usuario = self.usuario
        }
    }

}
