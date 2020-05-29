//
//  TipoMascotaViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire

class TipoMascotaViewController: UIViewController {
    
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    
    var usuario: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        dogButton.layer.cornerRadius = dogButton.frame.size.height / 3
               catButton.layer.cornerRadius = catButton.frame.size.height / 3
               print(usuario + " Tipo")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "TipoDeMascotaToPerro" {
            guard let perroVC = segue.destination as? PerroViewController else {
                return
            }
            perroVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "TipoDeMascotaToGato" {
            guard let gatoVC = segue.destination as? GatoViewController else {
                return
            }
            gatoVC.usuario = self.usuario
        }
    }

}
