//
//  GroupTableViewCell.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/18/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    var group:Group? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    
    
    func updateUI() {
        groupNameLabel.text = group?.name
        updatedAtLabel.text = group?.updatedAt
    }
    
}
