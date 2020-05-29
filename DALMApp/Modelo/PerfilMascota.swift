//
//  PerfilMascota.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import Foundation

struct PerfilMascota: Decodable {
    
    let exito: String
    let token: String
    let nombre_duenio: String
    let nombre_mascota: String
    let tipo: String
    let raza: String
    let edad: String
    let genero: String
    let tamanio: String
    let actividad_fisica: String
    let dieta: String
    let peso: String
    let prenia: String
    let lactancia: String
    
}

enum CodingKeysPM: String, CodingKey {
    case exito
    case token
    case nombre_duenio
    case nombre_mascota
    case tipo
    case raza
    case edad
    case genero
    case tamanio
    case actividad_fisica
    case dieta
    case peso
    case prenia
    case lactancia
}
