//
//  MonitoreoNivel.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import Foundation

struct MonitoreoNivelAgua: Decodable {
    let exito: String
       let token: String
       let estado_plato1: String
       let reserva_agua: String
       let plato_agua: String
}

struct MonitoreoNivelAlimento: Decodable {
    let exito: String
       let token: String
       let estado_plato2: String
       let reserva_alimento: String
       let plato_alimento: String
}

enum CodingKeysMNA: String, CodingKey {
    case exito
    case token
    case estado_plato1
    case reserva_agua
    case plato_agua
}

enum CodingKeysMNAl: String, CodingKey {
    case exito
    case token
    case estado_plato2
    case reserva_alimento
    case plato_alimento
}
