//
//  FichaTecnica.swift
//  DALMApp
//
//  Created by Marco Acosta on 28/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Modelo tabla de ficha técnica
import Foundation

//struct de información de perfil
struct DataSheet {
    let fieldName: String
    let fieldInformation: String
}

//struct de horario
struct ScheduleInformation {
    let day: String
    let hour: String
    let portionFood: String
}

//struct encabezados horario
struct HeaderSchedule {
    let dayH: String
    let hourH: String
    let portionFoodH: String
}
