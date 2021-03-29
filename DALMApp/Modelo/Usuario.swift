//
//  Usuario.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Modelo para decodificar la respuesta del webservice de usuario
import Foundation

//struct de usuario
struct Usuario: Decodable {
    let exito: String
    let token: String
}

enum CodingKeys: String, CodingKey {
    case exito
    case token
}
