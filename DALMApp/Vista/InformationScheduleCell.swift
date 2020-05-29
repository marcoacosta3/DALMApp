//
//  InformationScheduleCell.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit

class InformationScheduleCell: UITableViewCell {

    @IBOutlet weak var leftInformationScheduleView: UIView!
    @IBOutlet weak var leftInformationScheduleLabel: UILabel!
    @IBOutlet weak var middleInformationScheduleView: UIView!
    @IBOutlet weak var middleInformationScheduleLabel: UILabel!
    @IBOutlet weak var rightInformationScheduleView: UIView!
    @IBOutlet weak var rightInformationScheduleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftInformationScheduleView.layer.cornerRadius = leftInformationScheduleView.frame.size.height / 5
        middleInformationScheduleView.layer.cornerRadius = middleInformationScheduleView.frame.size.height / 5
        rightInformationScheduleView.layer.cornerRadius = rightInformationScheduleView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
