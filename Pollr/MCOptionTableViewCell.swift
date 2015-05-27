//
//  MCOptionTableViewCell.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/24/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class MCOptionTableViewCell: UITableViewCell {
 
    @IBOutlet weak var optionLabel: UILabel!
    
    var colorChanged:Bool = false {
        didSet {
            changeColor()
        }
    }
    
    var option:String? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        optionLabel.text = option!
    }
    
    func changeColor() {
    
        if colorChanged {
            optionLabel.textColor = UIColor.blueColor()
        } else {
            optionLabel.textColor = UIColor.blackColor()
        }
    }
    
}
