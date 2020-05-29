//
//  HeaderScheduleCell.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class HeaderScheduleCell: UITableViewCell {
    
    @IBOutlet weak var leftHeaderScheduleView: UIView!
    @IBOutlet weak var leftHeaderScheduleLabel: UILabel!
    @IBOutlet weak var middleHeaderScheduleView: UIView!
    @IBOutlet weak var middleHeaderScheduleLabel: UILabel!
    @IBOutlet weak var rightHeaderScheduleView: UIView!
    @IBOutlet weak var rightHeaderScheduleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
