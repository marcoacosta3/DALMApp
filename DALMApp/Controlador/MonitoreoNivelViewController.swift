//
//  MonitoreoNivelViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire

//Define la clase
class MonitoreoNivelViewController: UIViewController {
    
    //Outlets de los botones
    @IBOutlet weak var foodLevel: UIButton!
    @IBOutlet weak var waterLevel: UIButton!
    
    //Variable usuario para token
    var usuario: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Diseño de botones
        foodLevel.layer.cornerRadius = foodLevel.frame.size.height / 3
        waterLevel.layer.cornerRadius = waterLevel.frame.size.height / 3
        print(usuario + "Niveles")
    }
    
    //Método para preparar segue
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
