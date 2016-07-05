//
//  ServiceTableViewCell.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/4/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var ServiceLabel: UILabel!
    
    var service: Service? = nil {
        didSet {
            self.ServiceLabel.text = self.service?.name!
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
