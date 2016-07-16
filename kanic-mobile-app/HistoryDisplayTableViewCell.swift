//
//  HistoryDisplayTableViewCell.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/11/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class HistoryDisplayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var mechanicNameLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    
    var request: Request? {
        didSet {
            serviceNameLabel.text = request?.service
            if request?.mechanic != nil {
                mechanicNameLabel.text = request?.mechanic
            } else {
                mechanicNameLabel.text = "To be determined"
            }
            carNameLabel.text = request?.car
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.selected = false
        }
    }

}
