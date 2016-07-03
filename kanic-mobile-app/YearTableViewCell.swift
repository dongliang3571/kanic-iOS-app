//
//  YearTableViewCell.swift
//  kanic-mobile-app
//
//  Created by dong liang on 7/3/16.
//  Copyright © 2016 kanic. All rights reserved.
//

import UIKit

class YearTableViewCell: UITableViewCell {

    @IBOutlet weak var YearLabel: UILabel!
    
    var year: Int? = nil {
        didSet {
            self.YearLabel.text = "\(self.year!)"
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
