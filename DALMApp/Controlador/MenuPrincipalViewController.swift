//
//  MenuPrincipalViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire

//Define la clase
class MenuPrincipalViewController: UIViewController {
    
    //Outlets de los botones
    @IBOutlet weak var registerPetProfileButton: UIButton!
    @IBOutlet weak var scheduleSettingsButton: UIButton!
    @IBOutlet weak var addAudioButton: UIButton!
    @IBOutlet weak var levelMonitoringButton: UIButton!
    @IBOutlet weak var dataSheetButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    //Variable usuario para token e instancia de InfoService
    var usuario: String = ""
    let info = InfoService()
    
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
        
        //Diseño de botones
        registerPetProfileButton.layer.cornerRadius = registerPetProfileButton.frame.size.height / 3
        scheduleSettingsButton.layer.cornerRadius = scheduleSettingsButton.frame.size.height / 3
        addAudioButton.layer.cornerRadius = addAudioButton.frame.size.height / 3
        levelMonitoringButton.layer.cornerRadius = levelMonitoringButton.frame.size.height / 3
        dataSheetButton.layer.cornerRadius = dataSheetButton.frame.size.height / 3
        editProfileButton.layer.cornerRadius = editProfileButton.frame.size.height / 3
        logOutButton.layer.cornerRadius = logOutButton.frame.size.height / 3
        
        //Botones de horario, audio y editar perfil deshabilitados de inicio
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
    
    //Action que mostrará acerca de
    @IBAction func didTapInfoButton(_ sender: UIButton) {
        let infoVC = info.alert()
        present(infoVC, animated: true)
    }
    
    //Método que verificica si hay una mascota registrada
    func petAlreadyRegistratedRest(usuario: String) {
        
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/modificarPerfil.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo PerfilMascota
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: PerfilMascota.self) { (response) in
            print(response.result)
            
            //Habilita o deshabilita botones de horario, audio y editar perfil dependiendo si hay o no una mascota registrada
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
    
    //Método para preparar segue
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
