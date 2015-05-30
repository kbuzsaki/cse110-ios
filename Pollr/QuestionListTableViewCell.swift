//
//  QuestionListTableViewCell.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/26/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var question:Question? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        println(question!.type)
        titleLabel.text = question!.title!
        timeStampLabel.text = question?.poll?.createdAt?.timeAgoSinceNow()
    }

}
