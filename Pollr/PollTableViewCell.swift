//
//  PollTableViewCell.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/22/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class PollTableViewCell: UITableViewCell {

    @IBOutlet weak var pollName: UILabel!
    @IBOutlet weak var numQuestions: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    var poll:Poll? {
        didSet {
            poll?.inflate()
            updateUI()
        }
    }
    
    func updateUI() {
        pollName.text = poll?.name
        
        numQuestions.text = "\(poll!.questions!.count) question"
        
        if(poll!.questions!.count > 1) {
            numQuestions.text?.append(Character("s"))
        }
        
        timeStamp.text = poll?.last_modified
    }
}

