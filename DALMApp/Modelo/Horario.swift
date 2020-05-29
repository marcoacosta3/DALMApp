//
//  Horario.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import Foundation

struct Horario: Decodable {
    
    let exito: String
    let token: String
    let domingo: [String]
    let lunes: [String]
    let martes: [String]
    let miercoles: [String]
    let jueves: [String]
    let viernes: [String]
    let sabado: [String]
    let gramos: Int
}

enum CodingKeysH: String, CodingKey {
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
