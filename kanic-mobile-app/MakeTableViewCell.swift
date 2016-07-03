//
//  MakeTableViewCell.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/2/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class MakeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var makeNameLabel: UILabel!
    
    var make: Make? = nil {
        didSet {
            self.makeNameLabel.text = make!.name
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
