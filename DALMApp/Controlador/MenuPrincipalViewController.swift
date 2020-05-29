//
//  MenuPrincipalViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire

class MenuPrincipalViewController: UIViewController {
    
    @IBOutlet weak var registerPetProfileButton: UIButton!
    @IBOutlet weak var scheduleSettingsButton: UIButton!
    @IBOutlet weak var addAudioButton: UIButton!
    @IBOutlet weak var levelMonitoringButton: UIButton!
    @IBOutlet weak var dataSheetButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    var usuario: String = ""
    
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

        registerPetProfileButton.layer.cornerRadius = registerPetProfileButton.frame.size.height / 3
                scheduleSettingsButton.layer.cornerRadius = scheduleSettingsButton.frame.size.height / 3
                addAudioButton.layer.cornerRadius = addAudioButton.frame.size.height / 3
                levelMonitoringButton.layer.cornerRadius = levelMonitoringButton.frame.size.height / 3
                dataSheetButton.layer.cornerRadius = dataSheetButton.frame.size.height / 3
                editProfileButton.layer.cornerRadius = editProfileButton.frame.size.height / 3
                logOutButton.layer.cornerRadius = logOutButton.frame.size.height / 3
                
                scheduleSettingsButton.isEnabled = false
                scheduleSettingsButton.alpha = 0.5
                addAudioButton.isEnabled = false
                addAudioButton.alpha = 0.5
                editProfileButton.isEnabled = false
                editProfileButton.alpha = 0.5
                petAlreadyRegistratedRest(usuario: usuario)
        //        navigationController?.isNavigationBarHidden = true
                print(usuario)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func petAlreadyRegistratedRest(usuario: String) {
        let url = "http://n-systems-mx.com/tta069/controlador/modificarPerfil.php"
        let parameters = ["token": usuario]
        
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: PerfilMascota.self) { (response) in
            print(response.result)
            
            let disableEditProfileButton = response.value?.tipo ?? ""
            print(disableEditProfileButton)
            if disableEditProfileButton == "" {
                self.scheduleSettingsButton.isEnabled = false
                self.scheduleSettingsButton.alpha = 0.5
                self.addAudioButton.isEnabled = false
                self.addAudioButton.alpha = 0.5
                self.editProfileButton.isEnabled = false
                self.editProfileButton.alpha = 0.5
            }else {
                self.scheduleSettingsButton.isEnabled = true
                self.scheduleSettingsButton.alpha = 1.0
                self.addAudioButton.isEnabled = true
                self.addAudioButton.alpha = 1.0
                self.editProfileButton.isEnabled = true
                self.editProfileButton.alpha = 1.0
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalToTipoMascota" {
            guard let tipoMascotaVC = segue.destination as? TipoMascotaViewController else {
                return
            }
            tipoMascotaVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalToHorario" {
            guard let horarioVC = segue.destination as? HorarioViewController else {
                return
            }
            horarioVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalToAudio" {
            guard let audioVC = segue.destination as? AudioViewController else {
                return
            }
            audioVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalToMonitoreoNivel" {
            guard let monitoreoNivelVC = segue.destination as? MonitoreoNivelViewController else {
                return
            }
            monitoreoNivelVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalToFichaTecnica" {
            guard let fichaTecnicaVC = segue.destination as? FichaTecnicaViewController else {
                return
            }
            fichaTecnicaVC.usuario = self.usuario
        }
        
        if let identifier = segue.identifier, identifier == "MenuPrincipalToEditarPerfil" {
            guard let editarPerfilVC = segue.destination as? EditarPerfilViewController else {
                return
            }
            editarPerfilVC.usuario = self.usuario
        }
        
        //        if let identifier = segue.identifier, identifier == "DesconectarToLogin" {
        //            guard let loginVC = segue.destination as? ViewController else {
        //                return
        //            }
        //            loginVC.usuario = usuario
        //        }
        
    }

}
