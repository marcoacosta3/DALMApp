//
//  Usuario.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import Foundation

struct Usuario: Decodable {
    let exito: String
    let token: String
}

enum CodingKeys: String, CodingKey {
    case exito
    case token
}
