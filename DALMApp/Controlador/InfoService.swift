//
//  InfoService.swift
//  DALMApp
//
//  Created by Marco Acosta on 03/06/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class InfoService {
    
    func alert() -> InfoViewController {
        
        let storyboard = UIStoryboard(name: "Info", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "InfoVC") as! InfoViewController
        
        return alertVC
    }
}
