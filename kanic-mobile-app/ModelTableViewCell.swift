//
//  ModelTableViewCell.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class ModelTableViewCell: UITableViewCell {

    @IBOutlet weak var ModelLabel: UILabel!
    
    var model: Model? = nil {
        didSet {
            ModelLabel.text = model!.name
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
