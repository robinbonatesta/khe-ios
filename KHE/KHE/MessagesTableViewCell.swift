//
//  MessagesTableViewCell.swift
//  KHE
//
//  Created by Paul Dilyard on 9/3/15.
//  Copyright (c) 2015 HacKSU. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class MessagesTableViewCell: UITableViewCell {


    @IBOutlet weak var messageLabel: TTTAttributedLabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
