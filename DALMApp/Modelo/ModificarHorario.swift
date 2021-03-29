//
//  ModificarHorario.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Modelo para decodificar la respuesta del webservice del horario
import Foundation

//struct para modificar el horario
struct ModificarHorario: Decodable {
    
    let exito: String
    let token: String
    let domingo: [String]
    let lunes: [String]
    let martes: [String]
    let miercoles: [String]
    let jueves: [String]
    let viernes: [String]
    let sabado: [String]
    let gramos: String
}

enum CodingKeysMH: String, CodingKey {
    case exito
    case token
    case domingo
    case lunes
    case martes
    case miercoles
    case jueves
    case viernes
    case sabado
    case gramos
}
