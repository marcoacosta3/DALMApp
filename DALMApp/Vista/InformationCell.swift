//
//  InformationCell.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class InformationCell: UITableViewCell {
    
    @IBOutlet weak var leftInformationView: UIView!
    @IBOutlet weak var leftInformationLabel: UILabel!
    @IBOutlet weak var rightInformationView: UIView!
    @IBOutlet weak var rightInformationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftInformationView.layer.cornerRadius = leftInformationView.frame.size.height / 5
        rightInformationView.layer.cornerRadius = rightInformationView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
