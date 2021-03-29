//
//  FichaTecnicaViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire

//Define la clase
class FichaTecnicaViewController: UIViewController {
    
    //Outlet de la tabla
    @IBOutlet weak var tableView: UITableView!
    
    //Variables de la tabla
    var information: [DataSheet] = []
    var header: [HeaderSchedule] = [
        HeaderSchedule(dayH: "Día", hourH: "Hora", portionFoodH: "Porción")
    ]
    var schedule: [ScheduleInformation] = []
    
    var petGenreData: [String] = [String]( )
    var petAgeData: [String] = [String]()
    var petWeightData: [String] = [String]()
    //Variable usuario para token
    var usuario: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        //Se registra los tipos de celda en la tabla
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        tableView.register(UINib(nibName: K.cellNibNameS, bundle: nil), forCellReuseIdentifier: K.cellIdentifierS)
        tableView.register(UINib(nibName: K.cellNibNameHS, bundle: nil), forCellReuseIdentifier: K.cellIdentifierHS)
        
        petGenreData = ["Macho", "Hembra"]
        petAgeData = ["Minino", "Adulto", "Vejez", "Cachorro hasta 10 semanas", "Cachorro de 10 semanas a 6 meses", "Cachorro de 6 hasta 12 meses", "Adulto (De 1 a 5 años)", "Vejez (Mayor a 5 años)"]
        petWeightData = ["De 1 a 2kg", "De 3 a 5kg", "Más de 5kg", "Menor de 3.5kg", "Entre 3.5-7.5kg", "Entre 7.5-11.5kg", "Entre 11.5-15.5kg", "Entre 15.5-19.5kg", "Entre 19.5-23.5kg", "Entre 23.5-27.5kg", "Entre 27.5-33.5kg", "Entre 33.5-39kg", "Entre 39.5-45.5Kg", "Entre 45.5-50Kg"]
        
        print(usuario + " Ficha")
        petProfileRest(usuario: usuario)
        scheduleRest(usuario: usuario)
    }
    
    //Método para obtener la información del perfil de mascota
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
            guard let informationResponse = response.value else { return }
            //Añade la información obtenida a la tabla
            self.information.append(DataSheet(fieldName: "Dueño", fieldInformation: informationResponse.nombre_duenio))
            self.information.append(DataSheet(fieldName: "Mascota", fieldInformation: informationResponse.nombre_mascota))
            self.information.append(DataSheet(fieldName: "Raza", fieldInformation: informationResponse.raza))
            self.information.append(DataSheet(fieldName: "Género", fieldInformation: self.petGenreData[(Int(informationResponse.genero) ?? 0) - 1] as String))
            self.information.append(DataSheet(fieldName: "Edad", fieldInformation: self.petAgeData[(Int(informationResponse.edad) ?? 0) - 1] as String))
            self.information.append(DataSheet(fieldName: "Peso", fieldInformation: self.petWeightData[(Int(informationResponse.peso) ?? 0) - 1] as String))
            self.information.append(DataSheet(fieldName: "Dieta Especial", fieldInformation: informationResponse.dieta))
            
            self.tableView.reloadData()
        }
    }
    
    //Método para obtener el horario
    func scheduleRest(usuario: String) {
        
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/modificarHorario.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo ModificarHorario
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: ModificarHorario.self) { (response) in
            print(response.result)
            guard let informationResponseS = response.value else { return }
            //Añade la información obtenida a la tabla
            self.schedule.append(ScheduleInformation(day: "Lunes", hour: informationResponseS.lunes.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            self.schedule.append(ScheduleInformation(day: "Martes", hour: informationResponseS.martes.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            self.schedule.append(ScheduleInformation(day: "Miércoles", hour: informationResponseS.miercoles.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            self.schedule.append(ScheduleInformation(day: "Jueves", hour: informationResponseS.jueves.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            self.schedule.append(ScheduleInformation(day: "Viernes", hour: informationResponseS.viernes.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            self.schedule.append(ScheduleInformation(day: "Sábado", hour: informationResponseS.sabado.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            self.schedule.append(ScheduleInformation(day: "Domingo", hour: informationResponseS.domingo.joined(separator: ", "), portionFood: informationResponseS.gramos + "g"))
            
            self.tableView.reloadData()
        }
    }
    
}

extension FichaTecnicaViewController: UITableViewDataSource {
    
    //Método para saber cuantas filas tiene la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return information.count
        }else if section == 1{
            return header.count
        }else if section == 2 {
            return schedule.count
        }
        return 0
        
    }
    
    //Método para llenar con la información la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! InformationCell
        let cellS = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierS, for: indexPath) as! InformationScheduleCell
        let cellHS = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierHS, for: indexPath) as! HeaderScheduleCell
        
        if indexPath.section == 0{
            cell.rightInformationLabel.text = information[indexPath.row].fieldInformation
            cell.leftInformationLabel.text = information[indexPath.row].fieldName
            return cell
        }else if indexPath.section == 1 {
            cellHS.leftHeaderScheduleLabel.text = header[indexPath.row].dayH
            cellHS.middleHeaderScheduleLabel.text = header[indexPath.row].hourH
            cellHS.rightHeaderScheduleLabel.text = header[indexPath.row].portionFoodH
            return cellHS
        }else if indexPath.section == 2 {
            cellS.leftInformationScheduleLabel.text = schedule[indexPath.row].day
            cellS.middleInformationScheduleLabel.text = schedule[indexPath.row].hour
            cellS.rightInformationScheduleLabel.text = schedule[indexPath.row].portionFood
            return cellS
        }else{
            return cell
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        if section == 0 {
    //            return "Information"
    //        }else {
    //
    //            return "Horario"
    //        }
    //
    //    }
    
    //Método del número de secciones de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
}
